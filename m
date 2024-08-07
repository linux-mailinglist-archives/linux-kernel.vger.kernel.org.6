Return-Path: <linux-kernel+bounces-277216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB3E949DF7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47FB1F21C96
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B5418FDB3;
	Wed,  7 Aug 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="aPFezs42"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E61C3D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722999385; cv=none; b=KI56ZeoRa51vcsLr7lry46SdHzFekZA4d5kEl+VWLMRsdE9D8MWB/HOIj0XCR7fmfps+cp0f4JD8bn2hLXNw/im+kkaKPCyFEjFfsYOPmsHc7l/6UrFwHPfDg4VX4dVanpebUUxdGvJU47dqQC2B3pqzQ7zmtm/7/iE7RZimzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722999385; c=relaxed/simple;
	bh=JBpBBhkDJfOw3+w90FL4ukIexECNtzJq8a86OZUQaLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K08wPlGpXStp5EL4LqIIPf7/wXoqJi3hvWNz3JsJj7nJrDd52in0GD2bwWMTWWzdn5eWDS+RVMk7HtfVaM+AK/4YINSloi8FdyKWyY6U3FxMKvL7n2wkpODisvsmGPcMGoB1eiHBkdN7clkf0Sbqkepl1gMBszA0sMsDOVR4Stk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=aPFezs42; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd69e44596so3546115ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 19:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722999383; x=1723604183; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o+V4K81vXA0WeuPGCt6+s1/avlSkzQ1zOQany/lZfO0=;
        b=aPFezs42scbjusZndJz4pTA4vck5+6G1qvWygWkxhzSomUujxwk52fo/bwAxuRXyRj
         FANzJQENEV4qyOHS5bRyp9jxkHGroAJ0DnbrzPau4+ieevqSozrlseiL5Hz4tmMjWOpI
         Qo3IMiQ7lBPmmwC80Ym0MAcnMtre7zL7ON1xTxRlezrQD4rC/6EdVqcvTd5NBoy2p+UM
         Jsm/g4jjnED1YXnGSeIIO5RzKt9KUexBcf8/xiqA68yR7QOjIs/zI4VOFPbzjL0PbcDg
         BbSuQr/TeV8ngeJNNc+/YMYCMqqgs7v8IST30EuBddf8QADSXYJMnQjxj5221fO5qeq2
         NtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722999383; x=1723604183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+V4K81vXA0WeuPGCt6+s1/avlSkzQ1zOQany/lZfO0=;
        b=kOoZ2LrzvDCHxQ8mWw/PCBD8n1jksIMeQPFHqF1DSg8jw1OGaaLpBf/9wCOJ70lY8Y
         cIuwb//pTpzFrsY6i2WGTYccsKSccavCQgfXgXzqJsPzxuwjuWyofL0NW4BRxNhlYRgR
         Ctcg4kI5gAkRtlUhfEhejdZO/1k5KdpjzWc3PGaa4lPoK9nNhfJ6jQG5cIfjP7DVURKq
         ZmgEcADyYHTQ5hxeCY3wqiMSJ2RQAONQhbcIC4VUgNjhz800gyIhqjoI7F9q96tQMGvh
         d3lbFtOY4fvjTTgX66K0mZhBLvrhR+2Dq3CnUXKzaXLO31pO8IZJ8caPspxR39HcRpSg
         LyXA==
X-Forwarded-Encrypted: i=1; AJvYcCXKmS3pp1lY2QsSSZGHdECBFdCs6Vecqb3x7oVh2wu79LaAXyZ4bieTq0aeTSn+zbaTGM0CSnokopKa0wqP5JZLVl1TPohLgpRDE2F4
X-Gm-Message-State: AOJu0Yyh4UTJRbm9mWUIZmrIV1B9xNdUa89nbFf4egrRpJ8aPRdyA0vY
	SAMLBTh3f9hvqgRXEOod1X5DVHTzeMmnetcNLM7Yyme9UllJftt9LYInWkq3wHI=
X-Google-Smtp-Source: AGHT+IFFWSdGW3Xq4NimlVtQbi66SucoaH++gBvkskF4/64XmMaDXQsEPFAluYx4y3Hn/v7cWQpKqA==
X-Received: by 2002:a17:902:d4ca:b0:1ff:43a8:22f2 with SMTP id d9443c01a7336-20085523055mr12362815ad.24.1722999382850;
        Tue, 06 Aug 2024 19:56:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5917b6eesm94502555ad.222.2024.08.06.19.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 19:56:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sbWqZ-0084r0-1U;
	Wed, 07 Aug 2024 12:56:19 +1000
Date: Wed, 7 Aug 2024 12:56:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <ZrLiU+gGUKIOk1kA@dread.disaster.area>
References: <20240806144628.874350-1-mjguzik@gmail.com>
 <ZrKo23cfS2jtN9wF@dread.disaster.area>
 <CAGudoHEt-mmZaihzTYxmf3KF_LsEC=astL2fOB+SOWGMPOCcFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEt-mmZaihzTYxmf3KF_LsEC=astL2fOB+SOWGMPOCcFw@mail.gmail.com>

On Wed, Aug 07, 2024 at 12:55:07AM +0200, Mateusz Guzik wrote:
> On Wed, Aug 7, 2024 at 12:51 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Aug 06, 2024 at 04:46:28PM +0200, Mateusz Guzik wrote:
> > >       error = may_open(idmap, &nd->path, acc_mode, open_flag);
> > > -     if (!error && !(file->f_mode & FMODE_OPENED))
> > > -             error = vfs_open(&nd->path, file);
> > > +     if (!error && !(file->f_mode & FMODE_OPENED)) {
> > > +             BUG_ON(nd->state & ND_PATH_CONSUMED);
> >
> > Please don't litter new code with random BUG_ON() checks. If this
> > every happens, it will panic a production kernel and the fix will
> > generate a CVE.
> >
> > Given that these checks should never fire in a production kernel
> > unless something is corrupting memory (i.e. the end is already
> > near), these should be considered debug assertions and we should
> > treat them that way from the start.
> >
> > i.e. we really should have a VFS_ASSERT() or VFS_BUG_ON() (following
> > the VM_BUG_ON() pattern) masked by a CONFIG_VFS_DEBUG option so they
> > are only included into debug builds where there is a developer
> > watching to debug the system when one of these things fires.
> >
> > This is a common pattern for subsystem specific assertions.  We do
> > this in all the major filesystems, the MM subsystem does this
> > (VM_BUG_ON), etc.  Perhaps it is time to do this in the VFS code as
> > well....
> 
> I agree, I have this at the bottom of my todo list.

Good to know.

> The only reason I BUG_ON'ed here is because proper debug macros are not present.
> 
> fwiw v2 does not have any of this, so...

Yeah, I didn't notice there was a v2 patch before I wrote this.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

