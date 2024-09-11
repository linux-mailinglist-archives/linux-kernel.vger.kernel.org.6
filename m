Return-Path: <linux-kernel+bounces-324382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B890974BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD7E1F25D74
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5C13D539;
	Wed, 11 Sep 2024 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZgjrRME"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7213C83D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041139; cv=none; b=ofQcFITd6syoEvyBaAgKSQXqj37YPwh3DBFSJaj06JnPZQBLjJHVr0Uj1f0vDpPmw65i4kCV2rOsbJgS3XBhI4sZhNtPzOAKfECy7cXI5gYj/g1CRkBpllPl5X+b+EoXUUXnXrj9J1p3PjeMkUPCDZJdWVXmWb1/oZ3r1Mz0HQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041139; c=relaxed/simple;
	bh=gySaOFRHBtcljdSeXk5NTlv58piwgRt6if/IxQF/UWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGReBgdlCIPHPzbkBkkzFJY7M1VahOPD916xdeWDsag8q9E1mqOuhlntLKrMzBe+Yp9lHD4hhrnCJ5TGJl/l+FPhxTb9a/lqSxnvnpUB3p7qq36qz7XywS3rQuoFee2uh0ydiwmnGaTENbkAUTAxYpP3SDmcuHqH67cefLGhO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZgjrRME; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso3559615e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726041136; x=1726645936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxxfET3fM3V/9CRMIOk0EfCrmZYUH+MdAUwdBUw1Geo=;
        b=rZgjrRMEpHCC1DfbkeUXitYL4PqDVOnM0Es1ujz7JkLEp2xy5xRJuDecgqWEOqG1wE
         FMak6ehT8K5u+EqilCOjt21MOvj0peRFwubrtow3/g99xzCdn4emLmovXqtbatp7Bbp4
         fzZ1BMzO1a6MaOEdtW9MF4NKz2HkwOP6g3dy0J1xNPQkv50wj28oKQNnIai9G+GMllr9
         XTEeFUyZIZ+W2rRM3E+D5KfBHiygUHPOPyHM6rRJo/LE/7zDNkChjYNdTjooLQJybyLB
         DLIkFtjxSrUxhw73+rcDV2vPTnQpaeHd6fOS+VK6BYO7XeLa5rzzaPMkjwZLjttqSraO
         5h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041136; x=1726645936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxxfET3fM3V/9CRMIOk0EfCrmZYUH+MdAUwdBUw1Geo=;
        b=cR5n213k26rySb8CadasaxEIdkoaRDrthsvGfRqmbsBh5iwdxB33Qd/PrL9U2XLrbE
         srFVWdos5GsmMwMA4uxCFB+pf2W7iPVB+CIHarXsET7PYvU3+f4ogDNGPkeeZKD9975K
         hG3HK2uv7tshIJIMStqS7ghE1xaCkoZmInK5wCL2zsVNmab58kYZVRXt5k5CoueXoz+1
         qAfDfXVrkG1bwSfHBL7AyqOh3SqdQLNUkao2uF6NX3npu6ZLgq6KDKnUXlCHlyNT0Ewe
         dJoeQUPEGLDQ4jdSBNoYC4zGq2uJb/UjZMyIaO1qpRXfyhYOI6bkl6wuupDsqJkXXHFD
         ZxuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjiwnXEldfzs0lR4NB4pAtoAVRtTkwgehF5xjtmqz+vNaJTcQbu71IxO/vTUAxGYpK+yg33ocyFZyxPes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKn/4uCePgPV/sFhNeTJntzCCP2utgOpW2HB2PLKpQUi7INX+
	BhuJz2QIuPLjwYIb6J85RlQ3N5k1HSD4ZaeauyLtDbZIVz/Ewt5eI0vjNUV6Rw==
X-Google-Smtp-Source: AGHT+IH3vyKCf0knIMn61KvQCDAk4WW46zj0emh72vl4fMCsHLyzArOUiTDQfBxn8rt89/yvFSddxA==
X-Received: by 2002:a05:600c:1ca7:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-42cbddb8169mr33274305e9.4.1726041135777;
        Wed, 11 Sep 2024 00:52:15 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb179f8e3sm125126015e9.43.2024.09.11.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:52:15 -0700 (PDT)
Date: Wed, 11 Sep 2024 08:52:11 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@android.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire
 meta-page padding
Message-ID: <ZuFMK7yndArZo4pA@google.com>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-2-vdonnefort@google.com>
 <20240910124541.23426cee@gandalf.local.home>
 <14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>

On Tue, Sep 10, 2024 at 12:49:58PM -0600, Shuah Khan wrote:
> On 9/10/24 10:45, Steven Rostedt wrote:
> > 
> > Shuah,
> > 
> > Can you take this through your tree?
> > 
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> I can take this through my tree.
> 
> > 
> > -- Steve
> > 
> > 
> > On Tue, 10 Sep 2024 17:23:34 +0100
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > > Improve the ring-buffer meta-page test coverage by checking for the
> > > entire padding region to be 0 instead of just looking at the first 4
> > > bytes.
> > > 
> > > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > > Cc: linux-kselftest@vger.kernel.org
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> Vincent,
> 
> Can you please rebase these on linux-kselftest next branch and
> resend.  This patch doesn't apply.
> 
> Also please fix the subject to say:
> 
> selfttests/ring-buffer

Will do, but it depends linux-trace/ring-buffer/for-next which hasn't make it
yet to linux-next.

