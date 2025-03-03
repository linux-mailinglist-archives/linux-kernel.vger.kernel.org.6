Return-Path: <linux-kernel+bounces-541506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD6A4BDAA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA22D1738DE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E947F1F429C;
	Mon,  3 Mar 2025 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bFaaqw3Q"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05791F4284
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000066; cv=none; b=HmG28Kx/K/QJiB5bA3FdE5pTsq2nzwa6KrB8QPC10PbN+RMcNtV+I+1wrTH7TqZJb88tvYzNBJGRkZeFGc97dgQ5RWQay/GFwX+2ylp10WRmW4w/UTiJSrj7Xzw7PM4pfvardp82bZ+LmnxKbf54q/LgYBKBrwBp6+Qho+alHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000066; c=relaxed/simple;
	bh=1GgecRLa2f5MkYVd5GEY2hn4u5tEWq9NVu34El0c/8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNkBSGx4+mBPCVb9vIsY9l0PlY+/jQYrn+9BOhF50K/iW4rvMu2vtAW0gz3hdTAH5PAOv3p9tdTah0BqtnzNMv21ErsWcwnd8SSHaq7Q7j4EKB+KX66T7aLvEgz63ptbqp811P0NLi9QS+DrYWEtnLIBV9zR/F2Fa4bpw+Gx20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bFaaqw3Q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2576002f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741000063; x=1741604863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR6klagFtyciqTScqCxSlheZkToLksMe/ghF+ax1bKA=;
        b=bFaaqw3QdAfnuFGuAvtD1FNPpvOGlXqwPIAePppTseM4vLJMn2vMeKzPIBtgwgdVLZ
         No2Xxe6Tj5CLYoc4y7NJVgPMh9EumBiFNamHzJPBFNqpUb11T/4dLt2Mp1pVScLvxBAP
         KGSV8EbFPhyClemSbjJatilzT7C4yXVjaezDaAS3oSlvHp5PH1X2WmycuWORbp0W1UU7
         a7w26gElvlgEjAWznMQXCXpMDjUUr9ZuLP1UQjugX2NTh7W8wvuOztrSY1lr7NlAC963
         SzbNRbgjV66bM5jb+VCc0N32ZFC1eoJR8PVVQfnBoKt5L2j65b//WYLREzLnQ3EY8fa/
         RAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741000063; x=1741604863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR6klagFtyciqTScqCxSlheZkToLksMe/ghF+ax1bKA=;
        b=VoT7pzgDf+dakqMWEhdOGq2gUH+xo8P7lSRIHMsXzJaxGYkK434wGIXKGQd/XiUdAB
         n6HUoocGTffqckVA7wKTwUbYrDdw6hLlvtZ28RE0WUnyAAW4ydwFIu5YUfaQBfe+sMYM
         eznngoD6vbZYc2EgiOGGA70hGvPplyyHtuYelAMwkzoIMQJ9flIk2VuKw7z061IFLNo7
         CIXTs24Ef3IPGjwTQDQv6JC5fnhWzosIMyKs9dtpMf8UOaMlqDERUeGMm5nAY14PxkPJ
         bjdGYj9u3dYiQI4XMWtlCJ0NO1q9qg1AfIP0jTF7777jPnqbke9C/AcfLk1IP277i4IL
         IGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMjeghk+Ya82N8cp0RlA0Yrl7JHxgEQPeQL5Km17DBvAXSc74kgw1K89QepFkNtS+KHYlWjd0NXECZWM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylFycM3usnMSPzu8HXIlaSkwhO5YMuCyZDovvywmtA23i9gsi0
	d8fKq8DmTpEI7sya23sW9WPl2XOYuJoYyDNeIQj202KTv7z6RBBg5J1LU4O7d9I=
X-Gm-Gg: ASbGncucUGlAuYl1mJZVo3eHDPwZrl3PBEApd88aaRL6/31PH22W+FPjOpvjnUWjquB
	8Ad4qRzgdJCwAx7WMeGEWiNhZPPU5CTjIMzao8zIj9IX03Z62jxAq5ywOfxG3wTuPqgIC8msZnn
	xQJKKNjw4JfGaGjbxbqXuRd7XMhYwetchvcV3ghGSlZvqKnmUG1mF8fXBF3cq7ZlZB/6rhTjNc4
	2LzTi3pquaQVQna6jDwEtIa01CTls3tFytTPKZXzUsnM482Q5YxaCRLAkwBjvn3fdwwevlNkJPp
	lzuGsCoTMF5MNcwzHm6vDHcRNDS0mPaDEeRa4xfVMdWr
X-Google-Smtp-Source: AGHT+IFBGs8EDHlTN+81XRenAyQXyDufJuVA47cl0O3zAj0oS0wkjJQ0biMXNxnI2ZLtaTTO2C/nJw==
X-Received: by 2002:a05:6000:154b:b0:391:5f:fa10 with SMTP id ffacd0b85a97d-391005ffbc6mr4581143f8f.24.1741000061418;
        Mon, 03 Mar 2025 03:07:41 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a87sm14344403f8f.32.2025.03.03.03.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:07:41 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] at24: Drop of_match_ptr() and ACPI_PTR() protections
Date: Mon,  3 Mar 2025 12:07:39 +0100
Message-ID: <174100005548.29353.2871325520350905330.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250225100838.362125-1-andriy.shevchenko@linux.intel.com>
References: <20250225100838.362125-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 25 Feb 2025 12:08:38 +0200, Andy Shevchenko wrote:
> These result in a very small reduction in driver size, but at the cost
> of more complex build and slightly harder to read code. In the case of
> of_match_ptr() it also prevents use of PRP0001 ACPI based identification.
> In this particular case we have a valid ACPI/PNP ID that should be used
> in preference to PRP0001 but doesn't mean we should prevent that route.
> 
> With this done, drop unneeded of*.h inclusions and __maybe_unused markers.
> 
> [...]

Applied, thanks!

[1/1] at24: Drop of_match_ptr() and ACPI_PTR() protections
      commit: 51e36ca2251c5a47d8f7069d60fd07153cff3f36

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

