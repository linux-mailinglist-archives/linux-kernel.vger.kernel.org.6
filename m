Return-Path: <linux-kernel+bounces-241173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D9F9277CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC001F250DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6D91AEFD7;
	Thu,  4 Jul 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wyDArH+t"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00501ABC25
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102137; cv=none; b=JVPJQx9CDOU/wXPdiRZQYSpcWodBZrI5q46pfJEcTYyv5E0GZRsOykKTK45BQSvZkajdGfEjTeUWLFWrrK+fwEV+YeO2iZXScgCkyHsa1BhZDLT2h9rW8Trs0eD8Ba1x1v36VDp/FvdwWJNqGAKYOHvZFmDrk6lEA2oKm7mtV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102137; c=relaxed/simple;
	bh=OjnbuG9TO3j0bqvuijnRXhWJSCu36Kq2cDcGRW+hUIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmQidQ2IRF4MQ+/B6CtNTdXNWUNrWLO4hXJSjeanO6kzlChAwLTRb1ajzCt1k/eXaquYt1JZShOQeMA/oxoo/HM7gY0ndWc9ijLtwFpB2wjOtxSHthsxoqK9GlXgVu9hKhhli7MfOlj3qBpINK5RFeHnz38Ax731aCRBOAzOVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wyDArH+t; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so9878a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720102134; x=1720706934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OjnbuG9TO3j0bqvuijnRXhWJSCu36Kq2cDcGRW+hUIA=;
        b=wyDArH+tf1Df/l2NMx4gT9QOH5+MpABv6flQObIFKHaEDelV8WFn3v/0nYfbCrIz6N
         zcysWf2jjTyUw5LE6fKu41EH9/drrYPFnr1duVrut3an/ZE3Tyvr1QN6pJJJLQFv7YeN
         JuzaMFZn3MFUabp2m+7p4LcjCdrzemIbHjgnfShBBRxlc901XnmZy4zWLFextSKn71n/
         BqUK+Z92hbZwFeiWEe7ad5KvpPiv9RHW/JPdbY2yZJXT5E+31D8POC5CNHl7LDqw1jVQ
         HzuBZ+WfQpcPN9XcrfitVkKvhZaTo1U4cZhIlU7xQD16vONH7dadL/A1EFWRFeAyjWzr
         82oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720102134; x=1720706934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjnbuG9TO3j0bqvuijnRXhWJSCu36Kq2cDcGRW+hUIA=;
        b=hK+fJx7SnwNyHxDAvjRcj61BNl92k2BHSlal0CpQ3avtu/ps0qfpP1EnbJxYujq4Ql
         MGbETlK1IrPTyfi88yik9sc2se9pQczlD9L+TvG/SXMTyMpNcgNW8FA/8EiOK92NlIvy
         viMIDWrM0qkH2vT2zbNsbEw8Bim0T0krunAAQ0BvVvCZVgMDy/iFG1TvxmwKK8P/47rC
         yg4/tO1lX/7K/TBuLx+hKTr5OjklRvTv10xSqDaCm8Odm4KxGEAaggvuceysM8Qs2Pkv
         Pui4agSUsgrAusbLLcHvIkspchnWEvnQbVUv9gJ84rOIHSr4r8f4Rtbfu5ZpRS2qnlq+
         PhTg==
X-Forwarded-Encrypted: i=1; AJvYcCXWD609ce9ovv2S9hq89xcrhkfC/4sqmsbb+H7CMgQclg8Te2jIB+mFs62K8PmCTdp2j2gdNsoV0Pd5l/jumXvsx5KhgCEp5l3BO7eC
X-Gm-Message-State: AOJu0YxpmkmIbkDfWbO3RlHbrGmsACsGtAepHiuamVh2sBtxdFfaLaHn
	grP4eI3AVZ/MrbMyrt/T+l8z4lpwUQ+JR8de22Lio2Hoqx96ShN+yqOnygZieC1ZZXLVYlyp1dQ
	L/khlsaH92wMBusa+5EMh0sTtx4LZEsVHc0TJ
X-Google-Smtp-Source: AGHT+IFNnwi98SKMXkQJ3oJUKdSHHCJvcB2RfS4C3O9g2BWDLdJHEL3niZX6BcFP4guB/up0cv3ENf2NQHdkJ1jjNaw=
X-Received: by 2002:a50:d49c:0:b0:58b:5725:dedc with SMTP id
 4fb4d7f45d1cf-58e02738dbamr140013a12.4.1720102132332; Thu, 04 Jul 2024
 07:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023082746-antelope-drop-down-5562@gregkh> <20240704135057.1174408-1-dvyukov@google.com>
 <2024070416-hatbox-playlist-9886@gregkh>
In-Reply-To: <2024070416-hatbox-playlist-9886@gregkh>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 16:08:40 +0200
Message-ID: <CACT4Y+arKNML2gLvmXzqdfyJY5ydj0yjfk-NbrZpOLgTOTNH6A@mail.gmail.com>
Subject: Re: [PATCH] fs/befs: fix shift-out-of-bounds in befs_check_sb
To: Greg KH <gregkh@linuxfoundation.org>
Cc: 88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com, 
	Linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	luisbg@kernel.org, salah.triki@gmail.com, 
	syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 16:04, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 04, 2024 at 03:50:57PM +0200, Dmitry Vyukov wrote:
> > Hi,
> >
> > What's the kernel policy for such cases?
>
> What "case"?
>
> There is no context here at all, and I can't find any patch on lore at
> all.
>
> Please always properly quote stuff...

It's not easy with kernel lists. I used the lore suggested reply-to
command. Here is full thread:
https://lore.kernel.org/all/20240704135057.1174408-1-dvyukov@google.com/

