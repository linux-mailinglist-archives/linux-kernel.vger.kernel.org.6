Return-Path: <linux-kernel+bounces-211956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73234905960
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0026A284F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15871822FF;
	Wed, 12 Jun 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2filCzqK"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477B181D0E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211634; cv=none; b=mupX9Uc27mzvmzY9/HBAWGLdxWlaD8swwlgVCDRZ6APNOXQcH0nMnfQaBUujsyI7rh9GcAeOojtEJGx6IxeM6OEgi1Tl48sEjVF75s9zaZn/O3kjH07/c0V49FxkXOzLGcLF2+ZjE3Jx9KFlJUTXSPQrmMOyDAXvyjTRhNuEWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211634; c=relaxed/simple;
	bh=0RiU+QCieclrnIr84BvXghMGrcrPqnrFcb4cZOw1/n4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wgwqa4P7UorJQCKisBQfmF+fGkNf2YPViGkqgyKLmUyZdBzm3aL62eJ4tAZVcyDFWH31UMvtGtrU9aR9A4nViQO2JOikN9aTSMZau4+1sQNpNDZ10jrSoG8HarYfDJYvRGFGvpXWg5FaK/dfznmDFgYt+Ot6D8MMnAylCYVng/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2filCzqK; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d21cb38362so197551b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718211632; x=1718816432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX1VkR6HGzBOeMhfoel7DGB+ycEt/TVIYXsNONOxVDM=;
        b=2filCzqKZVp/Kh1X9DfPIs7kpCV+gSCACotbvtW6M21PYEdvJ0bHHUv56pllGYM57A
         sQoEZ5DN2NEm0gNI50LArJIc6VtiL2Ja8qsAPFcwR7YH0OfBnRzwLlroUqegbOlS2FGl
         j8AFFnJKdn4qw7fCneekF9JbH1RGFVRkyKrcOZeMUmjnvo6g9acwnd+mXShA9Keg6FEa
         mkKc3p6yetPtH/WuZkHVlfRk3X5zz+vIePQCTL/s07llmhMQqxpheplsoqXPRjz8c3z4
         iJl6JHixeIByNsyIF0lDPRD9pVlRkPw8eg3Dvm7YhJSnRU3eFx3fOsFswmFLEUygS8KC
         Rc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211632; x=1718816432;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HX1VkR6HGzBOeMhfoel7DGB+ycEt/TVIYXsNONOxVDM=;
        b=ca2OUxEaBKGr6a64SnVQXO0Du3h20KipNH6g8E/JoORSB56Ep12Kp3g2rwpTxRBERz
         x7qQe6h54kwPQtd/YRz4mgiKCpakUlb0S/5zcdy5rEesDKJKm6quFayujDfhsiKxzNOm
         jJBlYmoK9qGI/YWoh2GW5RqMqa6JdAtVCdp8iJc7WOslp2HlSY82W0SZ+VokSaqfnc2T
         Yn1XjOUJF2HvJ/TLAYSoLoPMlbremE9jje+ql61DriAdMocIztianGZIarggakb25ywk
         8zcv7juuDt0AlOUPtk8hmLKvlT/pJ6HGqSYaBzuBGYV3tpln6/YYKhQKe72DjF6FG3EF
         R+6g==
X-Forwarded-Encrypted: i=1; AJvYcCW+d+ptrxDEB4/Nxoj4bvjmoKEturt9nWO/Shx+qKPoM/hqLQC3PqW67cstwiHug9KlM2OycYDPp9c5shk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUq/uwmZIyKm7EmVTKE+zpbqVo7UTxySVh2nRGY8hnz7tchdGU
	NCnURF05wvWjMj6i4HcweaNUY4tzH+8AG30Vvpsmqr+IOQfoF2Ahoo0wnuANwYQ=
X-Google-Smtp-Source: AGHT+IFNFp9TcnPZQaeA8NtDjUBmrJZ05f290B/K9cvyX+mSyJGaTh5/YirVQhuU1UkR25e/+wUMnA==
X-Received: by 2002:a05:6808:1520:b0:3d2:1b8a:be6f with SMTP id 5614622812f47-3d23e1841d5mr2784962b6e.4.1718211628771;
        Wed, 12 Jun 2024 10:00:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d242affa88sm115841b6e.1.2024.06.12.10.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 10:00:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: jonathan.derrick@linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, Su Hui <suhui@nfschina.com>
Cc: jarkko@kernel.org, gjoyce@linux.vnet.ibm.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
In-Reply-To: <20240611073659.429582-1-suhui@nfschina.com>
References: <20240611073659.429582-1-suhui@nfschina.com>
Subject: Re: [PATCH] block: sed-opal: avoid possible wrong address
 reference in read_sed_opal_key()
Message-Id: <171821162747.49689.15711924368254843874.b4-ty@kernel.dk>
Date: Wed, 12 Jun 2024 11:00:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 11 Jun 2024 15:37:00 +0800, Su Hui wrote:
> Clang static checker (scan-build) warning:
> block/sed-opal.c:line 317, column 3
> Value stored to 'ret' is never read.
> 
> Fix this problem by returning the error code when keyring_search() failed.
> Otherwise, 'key' will have a wrong value when 'kerf' stores the error code.
> 
> [...]

Applied, thanks!

[1/1] block: sed-opal: avoid possible wrong address reference in read_sed_opal_key()
      commit: 9b1ebce6a1fded90d4a1c6c57dc6262dac4c4c14

Best regards,
-- 
Jens Axboe




