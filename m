Return-Path: <linux-kernel+bounces-177444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276B88C3EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D205F1F225C6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C34514A0A5;
	Mon, 13 May 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="amcaw6hN"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CE149E0F
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595408; cv=none; b=hZVqs9XjFMriUvPMG9ekABp24tx7FswbPzTCP8L8ObjLrHNMvKeEaXDG2lO33LLV6P1t2NyEJjURbhLcO7cDwOTIC+Zsq/fGffnZQODSp8jId5mvE22uIWHO/MLfQ/CEzlN6cbJLW13QlD4s0rcf2JVQOZbj6ASYacrujYgS9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595408; c=relaxed/simple;
	bh=w2J5OBBDrrWIOjx9hHEVak1hUfdidIUqnvnM42Q/rCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfJMj8Z9eavlbTh1W+PrRkm9gfDI2lHgL60WtdDFlbmXatraE+kus49u0WH24MNDiuhinDEKD/jjHyRtryshciZpYJLmToYE25/Aerb0Qyb2oFhvuBF4kq15Ja95E8Uc3jNpHuYRlhfT5XSaL11UMtqwyuCuBAeiL1p0kLozvcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=amcaw6hN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51ef64d051bso4675081e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715595404; x=1716200204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qyuzqvqTWW6REM5MvsMGdLvS+oewzpA8TVBEHmp2uw=;
        b=amcaw6hNvvJKk7nLW2XHg7QjY85edsMhzGw3XPrtGnIauQ7WtaLk063XptTH5gR3g3
         zAy4l4MK5tauL+uMpgLEDfrFvX1ib9xBhwdu2E0Tp5H3I6NXObd5mCa/rLmESCuEIXhx
         ZSqNDxqEZJNrPKmjn0Vv6tCWLMOj1SikPCvxiXh6tzEKY5WVFaUatvjuDJVHxCTmoPaE
         I3PhA93soWZB4gNk36iOnRRPUg8FbyYfLlVvBtGbNFvYYh69SlS1GPrBqu6SLkzwaeTg
         4fvUIgTyPnMRstI6MvnR5FvwaS0zIhUxKaDJ12Rq3n+vxd9mPM4TR28n4IfDBmRRjD57
         TZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715595404; x=1716200204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qyuzqvqTWW6REM5MvsMGdLvS+oewzpA8TVBEHmp2uw=;
        b=h/d/Z/H5kz9RTvF7Ij/tYPtuDvqEAhKUKNHsy29S5KuOcL4Q1s2w4nSbVGXE4gN5O/
         XQTR6GMRasF94rWFLdlAl0PP793O8RJcnV4UDIS4ZLSlvSSR/OtkxA4sBRo+3AoEu4T7
         TXYChnvJPFz06TSFt4S3UDuuwUqzlKOjMATL8oMqlk8ORgoHKXbCNjryByjl+M6LFQWu
         vTc8pa4R+8D8LamvVqoz3XpEKrmT38KOs3lyTgkr1pEJtH+3q4igsA06CVniFMxKCMs4
         TE4a0u4FWbBinIshuaZ6dJFRZbdJLSI/bOGIHF4+paThyonha2pfBzshDYhOrnluIt+6
         UV/w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1Zu1UEB8/jKmU8ReEtQIaeW8FGRQdLNJ8lCi5/7dAkarPRz0ISuicpWvIwr0aAAIzBmVhmBmtNnAb+wlmlDHuFPQkKKNqd2oRxVB
X-Gm-Message-State: AOJu0YytI2ZQMiZqDemu40IoEQ1ZhL1e08/yqD4IV7ie2+d1azInWpXX
	Q8tQvO9xLkvSK1VLB55MKmpTeJSt2GJLVagfbEqRPahKKOS4S/xNY5vkRjGmIjU=
X-Google-Smtp-Source: AGHT+IEoGJmlp8+IVb5iCgzv2JW8GXaqhiqx14ov/8u43xecwfEJyHh/E/EsbCinP88RKF/YGMWzQQ==
X-Received: by 2002:a05:6512:201:b0:51d:3a99:f22e with SMTP id 2adb3069b0e04-5220ff72e3amr5329107e87.59.1715595404303;
        Mon, 13 May 2024 03:16:44 -0700 (PDT)
Received: from vermeer ([2a01:cb1d:81a9:dd00:b570:b34c:ffd4:c805])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad02csm10654926f8f.67.2024.05.13.03.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 03:16:43 -0700 (PDT)
Date: Mon, 13 May 2024 12:16:41 +0200
From: Samuel Ortiz <sameo@rivosinc.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Qinkun Bao <qinkun@google.com>,
	"Yao, Jiewen" <jiewen.yao@intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
	linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] tsm: Allow for extending and reading
 configured RTMRs
Message-ID: <ZkHoiYMseU0XqEbR@vermeer>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <20240128212532.2754325-5-sameo@rivosinc.com>
 <ec7edddcf8c74e48cb392db0789b03243ab05692.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec7edddcf8c74e48cb392db0789b03243ab05692.camel@HansenPartnership.com>

On Fri, May 10, 2024 at 10:57:37PM -0400, James Bottomley wrote:
> I'm not really sure where to hang this, since there's no posted agenda
> or materials for the CCC meeting today.

The agenda was posted on the linux-coco ml [1]. I sent a link to the
presentation slides [2] to the thread.

> However, it struck me you missed a third option: use the ima log
> format.  This has the advantage that we can define additional events
> and have them published with a kernel patch (the IMA log format is
> defined in the kernel).  Thanks to the TCG, it's also CEL compatible
> but doesn't require any sort of TCG blessing of the events.  Plus we
> also have existing kernel infrastructure to log to that format.

That's an interesting idea. It may avoid having to extend the CEL spec
with a new Content Type, but otoh the current spec defines which IMA
events are supported. So adding new ones may require to also eventually
extend the spec. But I guess since IMA is a Linux kernel subsystem,
changing the kernel code and ABI would de-facto extend the TCG CEL IMA
spec.

Here I assume you're talking about the IMA_TEMPLATE CEL specified
format, which is designed to accomodate for the current kernel IMA log
format. The main drawback of this format is that the digest does not
include the whole content event, making the CEL content type, the IMA
tag name and both lengths (for the content event and the IMA content)
untrusted for event log verifiers.

CEL defines another IMA format (IMA_TLV), that hashes the whole event
content. I think we should at least use that format as our output ABI,
if we want to use a TCG specified IMA content type.

Cheers,
Samuel.

[1] https://lore.kernel.org/linux-coco/61b65115-5945-4e27-89e4-bb6cba657f7f@linux.intel.com/
[2] https://docs.google.com/presentation/d/1qMk-8TiMigVmVAEDWXqPu9Jd7OJ8AGvCR34Lp2WunhU/edit?usp=sharing

> Regards,
> 
> James
> 

