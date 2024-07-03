Return-Path: <linux-kernel+bounces-239167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7132F92576F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D64428613B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F312140E38;
	Wed,  3 Jul 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="D9IKPNio"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD3140E2E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000263; cv=none; b=FK+8ddqu+dnLT9lw6KMJr5J5bz5uofc64Cxzlw/BU6ASV16CdkXn5CHlEUsgKAr+evEM5EU32L+cTDeuDYNa15qA3or+m4rjNOLk1OSvRXoCOasojvKSvEkjLrEQIX3cMS0jpVoYykTvHvfznXsqh3lm89lHI25YpwXZWaqqrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000263; c=relaxed/simple;
	bh=Vyu6IlXQiIPpC6vfLbegmN3j0DyHLVXjOMkQJihHPtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtXyfY6ANWJ0FDjADDJABwtY5/Gr8e5k6ajjRIPxL9ZPqnst65UwDRKI68fjjIZD90VPQAzA2g5FnZZLllbElQBJoHJAhi/BnKFSSWeDseRYsaFJw9i9tB5AWxx7xVbnlSMojDLBJMqvK7PeI/tUMPPVNVLL01BkhCE25hozGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=D9IKPNio; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36701e6c6e8so2663238f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720000261; x=1720605061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1rzEDENBkHpjGzhf2xHO0Heehh3ZhgtF9ZJ32iq63Q=;
        b=D9IKPNioYy3B7r5wDr4qx7pIJxF7IEH1f6QiypLT0XVCAHoNFoT2ZLYThQhX90tc+X
         EstdXIxJ+T3s8JbaHYMUce7on2myJ6khGqr0QbsEQg8e4zJaPnex3OvaGoFmi8whPx7C
         l3imnp5J+Anok/JMx7Tn/yzZNRsQBx6sZ7yCK3gKqJrh7MVBqJj2578Nri91PGOLhn3b
         rNqTGQBZoMSFN1tegoaE7IJ0Gy5yNr/02r21GPwRA/W0EmbkgQFQd3+ks5GjIelTwH6C
         w/82oChRPV6Swl//KcMjoaOpYkpb5pFdjwwgjufyD3s4sEq84GjUYxvcQ0H/WphfXPb0
         Dz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720000261; x=1720605061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1rzEDENBkHpjGzhf2xHO0Heehh3ZhgtF9ZJ32iq63Q=;
        b=dcGJA2Yc7Bdo+hJ5NQ+0SfImtM7GxtMfxdbjG0w07drymkmgfk7lhJEYfvltfxqHPv
         sr/1I026eoIxMX6p2sKGDe/illkbXHciUrhXUfDDeONCf/0DLbPrklmDHQXxwMV1nAsf
         aG5l0ouIB22NCijvS5rpFUq3Mks/W43P4YHrS/7zszSc6Hf5Ygeft2+LhMrVBGNYo+GR
         fARk+Q4jOT9jolOr+UsiFfPfp6mxoQl6WswKcWQ3vyjg2osZotHAasn60WUt6ywYNXfp
         LdvQYkSrbc2O3nHtadm0ZqPtD//jrpgCnvmcIQwXitsFjmzYbQGoGU37PV9OquQSnBzi
         zlCg==
X-Forwarded-Encrypted: i=1; AJvYcCUptEURDkiRZ8GlTST9sdZicoDPJUOwex6L4j+XPsYRmd4Qywa3ZvlgppwYWCA6fwqEFpu22CMDurdl2Cp4iRw/mXYXBXHUsVeD5YGF
X-Gm-Message-State: AOJu0Yw5RGykPef3vBivz8yvi1j107Xo1TMOXAlBPzNXVUkMqnB0ejuV
	o8yMj+X3xMZwDujQ5aM+Q9ipPOV6vyltdaPOqpcted1z+sgyseWijmDWl3/Vgwc=
X-Google-Smtp-Source: AGHT+IHiRI35rZhomS9KcynZvFcqOHMN+Lgxf2PywudWY+ed5mqq19w9uOW0cBHaJt1eLdq/pskivw==
X-Received: by 2002:adf:fa47:0:b0:367:905c:823e with SMTP id ffacd0b85a97d-367905c82d9mr1168202f8f.24.1720000260670;
        Wed, 03 Jul 2024 02:51:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e143csm15379086f8f.59.2024.07.03.02.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:51:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>,
	superm1@kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Subject: Re: [PATCH v2] PCI/pwrctl: Don't show error when missing OF nodes
Date: Wed,  3 Jul 2024 11:50:59 +0200
Message-ID: <172000025606.10790.16891216053779987507.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702180839.71491-1-superm1@kernel.org>
References: <20240702180839.71491-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 02 Jul 2024 13:08:39 -0500, superm1@kernel.org wrote:
> commit 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF
> nodes of the port node") introduced a new error message about populating
> OF nodes. This message isn't relevant on non-OF platforms and
> of_platform_populate() returns -ENODEV in this case, so don't show the
> message on non-OF platforms.
> 
> 
> [...]

Applied, thanks!

[1/1] PCI/pwrctl: Don't show error when missing OF nodes
      commit: ba6294d28c428098e99a4139cde12ddb7e77bfa1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

