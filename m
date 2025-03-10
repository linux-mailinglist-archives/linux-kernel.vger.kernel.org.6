Return-Path: <linux-kernel+bounces-555069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF9A5A52C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796AE164D41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8AF1DEFEE;
	Mon, 10 Mar 2025 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="deu/J9Wa"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE531DE3AC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639392; cv=none; b=SCP35OLj1wvx+Rs4HcrJVkg1Q2s/xFJ6N/qoUhS8vH2okrjAxWy7wCYkhd3V+1Mz1P/1KUsn0kzRsp21+BjlI5fSTNFNkpyP9pXLtsjp1K3Pjc29MLH9tx+swal1BkbkAzFg8p2d254uO9GpdHl6PqQWMRgKjmfjoPgK7kfuhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639392; c=relaxed/simple;
	bh=3SrpO+SLfjeGySU4NOt+3eLm43DAaCmZFXhMiw2KWJk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ju2TpbMJTtAMyvy49uUfX5dCMih8jHnXOvQ4hg7M58TBOVeC1qtqmHRnf70SWkavs4fIeqpNTDFk4Aqp5KUq2Sne56kBQ5BtgNQB3BTT1ghsaCQ4X+Tsw0kvqoCZZJipY0R1MCvPuTCrsaVYaZqeNDymgHJf98xOBgpKRvq7+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=deu/J9Wa; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7272a839f3dso1030885a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741639388; x=1742244188; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1Uwtz0E2eftoKGPgXBkETiGlWCcSKKeqX6BxnxUh5k=;
        b=deu/J9WapJidEbiYp3rFVm8mLFBXyeIKSgV08pyFQVQdMZQVbZOXHytIF+TE6mperF
         UiBf1F1Am3SRBGAXjghb8AkF/CqHSK7W8dd6MBRg2KzbvRH2MsUmfZ4ea4Qlpjcl5qVb
         nzeRPfgz2rMoQUSyNByohDfmDnu0BTi0vmtIisDUB1SViMLKlWwqyqeRYPgQLCmSCZfH
         98M61rPa7nlQwMtIwL0VnXHCmzW5owyjFKI3orP4Lbg4yxufiVkL4HjAgbxeVFdQ/ajh
         iYLfsbV4l89+EJHaBu5QmEHc1H2JisCODNqbO4+EdFXSn4IwEJ9x7EGhali9bxfclijX
         KYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639388; x=1742244188;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1Uwtz0E2eftoKGPgXBkETiGlWCcSKKeqX6BxnxUh5k=;
        b=j9MIpJoE8zxdV+Ep0XmYp+5hOO75rqEF5O4bxgNZRQqqxhiQOGXEzuRfE0lsyHk9uj
         uDfmQPXe79QORW1lYKZoJU+l9Qdv85DFclPHNLEcG81QWe+EQPFkCnmTfG6gIpbuBx+F
         2CwP8J2RRVdAAXARDp78Kcw/BVdO0GqTyPa8Y0Z1O+9jiQBuBDAiHgwj+UykXocpMZLQ
         Tv6CaWhxaZ4KWOeb1UgMJdSMJ/86qIzaEmO9jfFddD18tJyIPHWUVSa+Q290xhyRRZhh
         C0s+pfO6Flg8A2nj82PtrwI8fxUlVRDnBJ4WI7rOhnweBrQGKlqYQ3gyNgXhWBuvnZoa
         YtgA==
X-Forwarded-Encrypted: i=1; AJvYcCXPfS6JDWXUGdB/S5wnTJHSIufSKSYpoUGU+ViwfwQ74zuDfagR2lCOSuhpIV1Wx9s5oW5CbP05DWP7T+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSaPRIjiXG8UnaUiRRhKr5dDk4OQ9KLQ+vQKBevNjJ6vR9JBg
	rvVfgdvI0t6La6dkLUHfBn7rLSrToi0a5Q8dQzS6DQmSiFLFnV9keQtPqMU2/X0=
X-Gm-Gg: ASbGnctOIhxC0BesX1uOYbOtrKme04jbR3qAYWfCtlwy69TDZLfar9jzJH52nJwRbb9
	muZT3j8JHhOv8YPYmFt2yBnySe2SyV850HPbcKSOXF0bNHdEAJFT032Hbbu3sI7SdvBzI3Q3HWg
	/UuXUawfAzV8GcgEng4UY1BwJtinVYu+ikb6lViTL/zuKUaSmxTFG6FwempiUj9E8S3M7Nu/L57
	zGxIpBPQfHec0ipn22JCp7IQiGg42Jzj7BzbENLyfja2iYVh2Ms09pp5FAvcWQ4XQD3MdZxqZdv
	53stSrUUbe9tlT9SngAE/KOVZ0Mfzredrm5D+qitS+rgh/DQ4XoTIRtnxgmSc9xF0m+bn7gMTPX
	g
X-Google-Smtp-Source: AGHT+IFCUqL25r0cgLNxG0Su4KlpP7XmTF9Z5pKvu36TT/JlzyZ/GaccoxuJ0kue1KZ4WSuhE3fdng==
X-Received: by 2002:a05:6808:3088:b0:3f4:bc5:d478 with SMTP id 5614622812f47-3fa2b30fb02mr502464b6e.25.1741639387999;
        Mon, 10 Mar 2025 13:43:07 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f855f69b1asm764315b6e.30.2025.03.10.13.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:43:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/5] iio: adc: ad4030: scan_type cleanups
Date: Mon, 10 Mar 2025 15:43:03 -0500
Message-Id: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdOz2cC/x2NwQqDMBAFf0X23IWNMWD7K6WHsL7WpRBlU4pF/
 PcGD3OYy8xOFW6odOt2cnyt2lKahEtHOufyAtvUnHrpk8QgbLZwnrQxSBTWGfrmqrnw57eC4c4
 yplEjYgpXpRZaHU/bzsn9cRx/MZClj3QAAAA=
X-Change-ID: 20250310-iio-adc-ad4030-check-scan-type-err-0858c3e3519c
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2

This started as patch to address an unchecked error return of
iio_get_current_scan_type(). Then while looking at other code related
to getting the scan_type, I noticed some opportunities to simplify the
driver a bit by removing some redundant code and clear up some things
that were not so obvious to me.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (5):
      iio: adc: ad4030: check scan_type for error
      iio: adc: ad4030: remove some duplicate code
      iio: adc: ad4030: move setting mode to update_scan_mode
      iio: adc: ad4030: don't store scan_type in state
      iio: adc: ad4030: explain rearranging raw sample data

 drivers/iio/adc/ad4030.c | 60 +++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 29 deletions(-)
---
base-commit: 66cadadbc94e18070245af7053f115061a73f016
change-id: 20250310-iio-adc-ad4030-check-scan-type-err-0858c3e3519c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


