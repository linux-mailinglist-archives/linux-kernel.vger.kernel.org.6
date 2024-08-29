Return-Path: <linux-kernel+bounces-306141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7746C9639D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AC528314E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC5149011;
	Thu, 29 Aug 2024 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Cmrrb9/+";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="g20h9r+k"
Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6043047A76
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908818; cv=none; b=sGHD9ZjP6G+XLcLRRjTWQ/i1CXyYxIugMczAD694kVUu/QwLPoM0xwIgmbqVXVMHnrT+vIiz5yRyxi1bVdLgZR4hCjG0qfWvUzMItymYrSEoAiISiN2KACG4H8fY3Uzfn7q2brEJPVaIsxayZjqPOBMiAJScD4YzfUJm7YUQFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908818; c=relaxed/simple;
	bh=Ia45hZSXNQ+K+dqO1AXNRzWvtG8wWud4WxNi7CoqRdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmPX5DiEE4gtBZB8U4gnIpDyGhn36Ab4OQd6QCZY/E4Yl/2OCKd0jS1pw5OYR5TQR4GrgUcSFKn5xZip/sl8xL3DRidG9ZUfQGrb+v0+4LPPEA+g4MnSMUXTDRFDcvf4/HOAqyrjmQDI3l/zuahfpmRJSDpLbdA8ZtskJysdW7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Cmrrb9/+; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=g20h9r+k; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724908817; x=1756444817;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=Ia45hZSXNQ+K+dqO1AXNRzWvtG8wWud4WxNi7CoqRdU=;
  b=Cmrrb9/+ECoOqBZLhfF9VXR+RMPfhP+6OFAhZ0hjt2sLs+Ge2rbXudxi
   yXPfaagM0HaTBtBv5JCFNB4VAx4DafqDA2Ub/TpBAfAR4AuCyiE2qK+4I
   ygzA36jvYIXcCV3EgKOPWyvQxuIWhht0VRVWzgn7gK1ujNq1i70QJvqL9
   zcquYXuMSIp2ATIKdYjhIi3PjRa7AAOK8AGXvxLFZoVZ2m9lVPSuPsKsT
   e/UZsmwCoylxDx1lfh8tF1krgLtED9nKnXT/RKKsJbnvXd3HDbiyUaVVb
   OCtmBXwTHWLU9n2cFe9LJ9J+laqoBG65Rc6JJ7Pvy5KxXeqgbHWNtEAx/
   g==;
X-CSE-ConnectionGUID: IvFe6iNOSWm0OKFvUn9RUw==
X-CSE-MsgGUID: HWbZEps8TUiZaZ91Uob71A==
Received: from mail-il1-f199.google.com ([209.85.166.199])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 22:20:17 -0700
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d465cd6ccso2725155ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724908815; x=1725513615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oihb+ZEx28nXHc0pAbgch0ZW5vY7lh30JIgO8BQjJuM=;
        b=g20h9r+kHYr9ncP5VuZl81agnzqYsGQWhRGskvA2AlXn+VbdPgREtfS7qjJ1xtF7Sr
         nGsf8oqnL8l7X03OE72GFa91hFF9O+rObVSkigALFUpQPE1VbTAuD9HRW0d4cpwPXa5w
         XydAwBH89moRlLQDCyaSFA0mdHD3y03GA/Pvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724908815; x=1725513615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oihb+ZEx28nXHc0pAbgch0ZW5vY7lh30JIgO8BQjJuM=;
        b=ArWh+Byv2nl0kISbeGjikd88df4tF/lJ8KHeY8JmmAEJQ+p1pqsOKsGQzpaJv/PnaV
         vqsXu9+HMNsL5dfYD8V83t4oQNBHa6zWqsGWEV4PDUcEYhHDgsJ3JHHj/3Xwn69nquUR
         a8jphUwPFUmnWDNSUZG27ujKrRCeWyK1NQuN5NOtkqQGeo/V7vMSgjfv8vDmPH+GXcvJ
         i85uFg4Clea54PHZ2ElQzCoqkLWQ5tVG1ZxFxDd2vgC+tnTzHD+0fnnuNQS/SnSdJxhu
         gzPmKCfdidBnlBu9x7xscV7eQE4D3QcnQ5PZNbGcUtaS4urgIExjDV0kBV3nff2opvvx
         poMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjlnMv8D0GtmUs0vhZrLpAcgdE/fk8k9nglvXJ3FvIm/m8QPdzuyP+dVcAg8trRYPozvkBMykwXGc6h7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8zLk4xUX8YVDS0BPDooc2CXZMldHLWGoXRLKi59KGk6SfPrG
	cI6KHL/hN7kWuQyI5XL9rH8RD7kHWP4KxTmhK7FUDbIAvKfn5R3g5b9pfQ277XwuDYx49ypYJc1
	WKtgzAGekzxkot8K6hQ0a5G36xN11a9USddXub4HSUsGsg2V6phM5a9RGXzFmtvB2VnBAe4/OGx
	d7rUiivEBmJpfnFDERWWXa5aRri4+BC4YiG47RIOZDriTRKBhKNUo=
X-Received: by 2002:a05:6e02:184c:b0:39b:389d:f7ce with SMTP id e9e14a558f8ab-39f378ec19fmr20753055ab.2.1724908815351;
        Wed, 28 Aug 2024 22:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtw1BOlLUaOKprgVjlL/LtyLeM1+0tuUpnn+kK49YRBERx/P+NDQeXjxtE+TO094UecuMe95yJy/8UvktdhKw=
X-Received: by 2002:a05:6e02:184c:b0:39b:389d:f7ce with SMTP id
 e9e14a558f8ab-39f378ec19fmr20752935ab.2.1724908815041; Wed, 28 Aug 2024
 22:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
 <Zs_gT7g9Dv-QAxfj@google.com>
In-Reply-To: <Zs_gT7g9Dv-QAxfj@google.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 22:20:04 -0700
Message-ID: <CALAgD-5-8YjG=uOk_yAy_U8Dy9myRvC+pAiVe0R+Yt+xmEuCxQ@mail.gmail.com>
Subject: Re: BUG: general protection fault in get_mem_cgroup_from_objcg
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>, Juefei Pu <jpu007@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Here is the kernel config file:
https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd

how long does it take to reproduce?
Juefei will follow on this, and I just CC'ed him.


On Wed, Aug 28, 2024 at 7:43=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, Aug 28, 2024 at 04:09:49PM -0700, Xingyu Li wrote:
> > Hi,
> >
> > We found a bug in Linux 6.10 using syzkaller. It is possibly a  null
> > pointer dereference bug.
> > The reprodcuer is
> > https://gist.github.com/freexxxyyy/315733cb1dc3bc8cbe055b457c1918c0
>
> Hello,
>
> thank you for the report. Can you, please, share the kernel config file?
> Also, how long does it take to reproduce?
>
> Thanks!



--
Yours sincerely,
Xingyu

