Return-Path: <linux-kernel+bounces-314400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3993996B2BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD572849AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868FB146588;
	Wed,  4 Sep 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UB2ImNvo"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B87145FE8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434593; cv=none; b=ax9+7MNsH4BMDrQTv8BEWGrNY4uVCrIutGmwGz3tS/yztKGAatbaFpi9ANw7cWG2RMlfd9liP52uj1j/rOVx8lv1yhui89jubYYsZ3XTsJtCc+XaoQKrACMklBcZRPTo0QL0SibFb0kZTV+VEqfNk7YMjjnN9L3pdsrLN212/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434593; c=relaxed/simple;
	bh=Wol+l7h7xHHknZATBRhJN5a344a5LUF4W0T8EdFbl+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deSY6cAtCP/G1jgr/ptFZgXVPvHt4j46lCJutImJgH7M/tkWCwHW1i3s3X7Fq/LgsC1F1IsxgvwA6mIHpS+ZpXRk0QQTJeTxBQnBtnao+EVUTzSiO7c7+Fr/2BZzsG8kAlcFlWyhvPRh55U0Rgnbt8DGcoVN3gLWyX6cGXvhEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UB2ImNvo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-375e5c12042so987047f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725434590; x=1726039390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+R5pD2HPGI2xG/eKo5tvfoHxIjYpk9F/MemAPX60CDY=;
        b=UB2ImNvo1+l1/oqZ+eQ//pWzwmvpQd5nWvPSIk0yimT/7omuuoMHTh84oeDmk76J7H
         zKv7uAYEtd9q5UviUy8x9giQTny+q/CDK8/WGLkf/2L0ZUVTdgRVBcWgtozeiyJMAfCU
         ignOyu0swWNkyiEJEZ7MRxgWYEphTqTaZi1k7GYuFunTxLqx/m1PMRJ7XfFqmRKoeZNX
         tPzTsEYdr4B2mW10M0e9JkfDJk1aiylxFthKJlkvgDkT7bXicH/14++rDp8lNHg/TwnY
         XqkTQ6RlhL6YXmpVGeDjEh3ctaJgLxv8NPHeAi/LCwQBN53FJG2sAD7pFutl5W5lEQUQ
         5UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434590; x=1726039390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+R5pD2HPGI2xG/eKo5tvfoHxIjYpk9F/MemAPX60CDY=;
        b=lhtp01Lw2VUGI71o7aJ6Y2O7WfEx5jlsCqWkD35M0BpH/h1LDfVxMgLjRJXZeOZzg3
         +hlBKMzz8IA+6VCIYpOZ8HRmNxVGWNdKV5U9XE+MsI6XLzlXFF26qu3oZZdvewRESJ5Q
         /OLzgmwvpxSKLRF2qSqcXKUHK2VN4rsn3Oh/L+y/LEowGHHasYkzuT+rwQAdzBTcCbe5
         72bN2UC4PaDbPTZllEHtQmqCwnNpp7qen0o/6qbQSddVARmUGShJNlo57pOGQCrU7xvy
         kGi7egFi4az0D7H6g2GQjARWKflm0dNwpdrXZWdL+FIueMYvl65Pamy9Uxni12L+XPyV
         QZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCUa3w0DBxeQUIScDG65c5/dEJpzrPt4e6OIftOSr9DWziilYXTJ2JFM8+vIhL1A1z2vpSoXSPpLQDBFxf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2pUzt2z4skh2VmqdfCWU+DebGqKmrLgoorakEmePh4nwpDUj
	q0Bw2T4ZegYW2H0foG0Rh87CCGJOjUE/6xAh0rIuNnjlcaUgsPtUPiLpKdi71EU=
X-Google-Smtp-Source: AGHT+IGugCBt/3ekQqKjAqXBGhd7+3aDpkIG0CBcrhe+Xjkh7b0j3/hfIT6gufpYxDFVJ2ez4X2H7Q==
X-Received: by 2002:a05:6000:1147:b0:374:c283:f7b7 with SMTP id ffacd0b85a97d-374ecc8f661mr4667861f8f.21.1725434588810;
        Wed, 04 Sep 2024 00:23:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:66d0:70f:5bef:d67d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ccab8a76sm6771906f8f.99.2024.09.04.00.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:23:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Martyn Welch <martyn.welch@collabora.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: mpc8xxx: order headers alphabetically
Date: Wed,  4 Sep 2024 09:23:07 +0200
Message-ID: <172543457723.9479.1909123590862180753.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903154533.101258-1-brgl@bgdev.pl>
References: <20240903154533.101258-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 03 Sep 2024 17:45:32 +0200, Bartosz Golaszewski wrote:
> Cleanup the includes by putting them in alphabetical order.
> 
> 

Applied, thanks!

[1/2] gpio: mpc8xxx: order headers alphabetically
      commit: ccaf84694ce7e7438706185c726310be51954fd3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

