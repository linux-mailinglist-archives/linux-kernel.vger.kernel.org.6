Return-Path: <linux-kernel+bounces-275432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E3948584
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFD71C22033
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667516C696;
	Mon,  5 Aug 2024 22:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaDSg3Vh"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2F149C4E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722898354; cv=none; b=dwJWQeufK2DDqUg5GIuTSzr8FFezhS1jDz7+jBYm9SyaDSbs2VFQleAjoUBocHtWVmUWv4YR7ckV39/yx2Vea1k60m/tqfflB3o4jsHSZfgZc2+XpWdNH2S46Mnd+wzRMb9DaXPW5uX0CmEGzRto42gCxMHZ9JO+qZ6AsPpvXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722898354; c=relaxed/simple;
	bh=QpQ4GLE96Of8/fhNE8TMauP6SoTZCvsRFLVIsvNsNcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ua+mEIy/wmvIBe25csKtqQQ0LLDOibHfyrfFuh0R6M5CSikkrF/V5PyxyiNg25XDnDq6nhiInlEKG18Rm43qVRiyn9lxtz3R//V57nyqE73mIiA/JJRYQz3Vp5GC7GKszJ6utgDv04qqObmGqWbbLeUVSH+4oW1qjgBZoGxoPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaDSg3Vh; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-492a3fe7e72so3275815137.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722898352; x=1723503152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R46EjL+R5WXCeo+6GWvtgRhTCD1cvgSUejxEkJYOUZc=;
        b=eaDSg3VhNW22d39LmFH1KITJAY7S7bguRMf1EZeGb+I92vtb/9OR7GT5SuTsGYWJV5
         rl6Opm1L85dM+OnqOdEN8B1I/UDEM8wy3DLLGkf3+B3XzorEuFWsn+L0oRmDhxImKIX8
         gcE/2E66yXJ3ZKm8cgaVVQl96KHEOziKiW9ns58DpOryNGq4OQi0GkihOtKhp/xoKpSy
         FjkphCMEqZVp2LXhvb5xCQdZmmaOXDi5EyUysY2oHq7On1PuUrTszLZ4d8+IC39/YlM5
         UMO2iXaCKyJfznfhUmR1u+PWnRb3hL5LlptCDc4+suzcCY6PehOvFRChW63HS6KzbiIN
         B9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722898352; x=1723503152;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R46EjL+R5WXCeo+6GWvtgRhTCD1cvgSUejxEkJYOUZc=;
        b=fjCWdsHVq4rZhO6Z0w00akr5TizYnrXDyP8l7ba40ZxP8DML4UF+JPIpnICaFwQhV4
         3i4r6hDmi9eqebRv1gaLtjAyfH1H+TLQL+7b5xUtRMy5vTjjkFiZ/+EZL58EFjgu7pN2
         n4QblE07g5RNCM4912A8CzO04M2Xas0PAy7uDPb1xz/8xCD531AOpCWeA0LMKIEXvmjW
         j9qWdBP9jI/jmjwQzZ2PqeX2j1q623Ds9IJ30HE6ZKO0lsje0BgLOFEtAZNXueM/VF64
         cctTAKpyy2pIms2Kzbuc75n3q8fpiLK5LltSD/ZT8pHC0aRU8ZxHG/6GRrMmceA4lNfe
         PRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0bhZCjHqmPr6LbvB3KLabWtWBzIi4tYYvZz3e6atFCvJGPCR+VfiIjGb/BhbrTYgkjAMEU8CvthBM/yKMKmVUdhRdOkGvs0CH0b1+
X-Gm-Message-State: AOJu0YwiPPTczeWF8OLoZgdlKOuN1hHpR3keKRNZ1hYzOSauKrpe8NZK
	zGbCc9Kk55h/pWVkIc2cun3ss7X3fzB7JE4nBav2+5JWHO7MA88d
X-Google-Smtp-Source: AGHT+IFalqazsexIgkoS5n3pNMBulKvMEDui2adpvNH4dBUYEIZXxXFRniHKZgnlTVlAAJ7q69jDyg==
X-Received: by 2002:a05:6102:945:b0:493:c092:ea15 with SMTP id ada2fe7eead31-4945bed6feemr20169167137.22.1722898352089;
        Mon, 05 Aug 2024 15:52:32 -0700 (PDT)
Received: from fedora ([2800:e6:4001:fca7:b7e8:4418:a953:72f2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-83c09450761sm1159666241.28.2024.08.05.15.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 15:52:31 -0700 (PDT)
Date: Mon, 5 Aug 2024 17:52:33 -0500
From: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: peterz@infradead.org, vincent.guittot@linaro.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Replace <asm/processor.h> with
 <linux/processor.h> in sched.h
Message-ID: <ZrFXsSCLej2EpKfh@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

rostedt@goodmis.org, linux-kernel@vger.kernel.org
Bcc: 
Subject: Re: [PATCH] sched: Replace <asm/processor.h> with
 <linux/processor.h> in sched.h
Reply-To: 
In-Reply-To: <n2ws7azgzp6mrrj4cl54xu36yjri5lbm4xo7edewjecti3623g@ra2dgaitoicb>

> Build and bootup Tested on ppc64le and x86.

Thanks for reviewing and testing! I really appreciate it.

Is there anything else missing from my side?

Regards,
-Juan José


