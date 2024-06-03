Return-Path: <linux-kernel+bounces-198780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4308D7D4B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7192D1F222D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA95A0FE;
	Mon,  3 Jun 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mNRUEUJv"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AD5674B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403148; cv=none; b=nn5Ntww+kCV2XqwqFzKOX5F+0LOqI6oNO+0f4O1IJXfSu57UsBoQcZLPhCiQWBCQM77qWShMoqti90TIrlb7n0fCAIkpXVvqbaMxmdOd1vnFjbeIgKRtO2uXFm9NnA4+vm0ItNU9ERcbu2DiDzfERqorOjEJZ45pBKAH9Hr3lBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403148; c=relaxed/simple;
	bh=nMrzAHRYbaM0CPzFYJoIrikgtExLbpIG/tDhr8hm/0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7qb4E79Qro39DXK/OkjQi42/bdDRPu1q466jllc+7l7+06LkrW/ugpxnx66+njKAS37YzbZDxTiPUBVH0sBBf0LUj18KWqu1AMzzFgcuF1pEt5vmZUQrbd8359O86fHvO3d3cKbCFXr94Jx+pVghDaSVbjIYe+ehOlvwHedtw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mNRUEUJv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b8f5d811aso2113322e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717403145; x=1718007945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvxlVn3WbqZZhkrp7NY7W//mMZJXucYwAeoohXFNboM=;
        b=mNRUEUJv9A6mykWnpIHQ2HKgXAx7PojPFI8yLR+nFUGOh8qvBDhbHrb7li9cbA1MgD
         Iv9aBYEj2TDcWFzLNpWU/FsCmQWfsm6OW5EUn62ptHqu3dKlgCLZW4E1V5z4BF6C80aN
         ZBKtbnRfAuUNtKBtk7wEDk4Yaw4Kba85WSqvGiZuwM7tx9IOnc8CdnYvAEraroxszDNF
         +T9YvB6LOeTH43OgmCRj/qlfd/RwyDBtr8Fdi1QPxmIEozLQDYCC+hxUCyvX7wR6M/zg
         YqTL6UWBRi/cwogCQIZa8eBP/5c6Hcx+ucinb82OkIl2A0hx4Y/0ydO8ltXfHvydAy/0
         RpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717403145; x=1718007945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvxlVn3WbqZZhkrp7NY7W//mMZJXucYwAeoohXFNboM=;
        b=enlW35IWYY4i3ry3b4NE842CaOzENx18J7ZNQAXynaGTSoqOZEtynUUhfr6jf9V/7+
         KacQE7a1INfvoj2q50K48+0+vvdPIsgXzc/a31tsNhTk5TTBI4cY1QTLD779ceu8cQuL
         TfBfY0ZGnanN84TJh0TRpnvpcHKu8mgEcXxzpW5g2wuN56D0S+yFo82H1VmM7I69Q24c
         x+D7Og6mf+2UUSW7AYlnX5nCm92sTx4zTvmcng8soAGw9JyHnzqYEQpOzKNqqtlfumYS
         qKjEkDnsobWfMXRE8UcLvWm/G3WQVNsPUeI4+bylNcLXYcODsu0s9Xi6FgReSqhujYpK
         S6Og==
X-Forwarded-Encrypted: i=1; AJvYcCW8MJDHmoAOc7d2FEFUqG4ncka8MP350vKfr7I9mbmA0e2flaMK0m3tFVV5d6ZQil+i9y4rYe4WMiuS0ADHuXPnAEDrmOGsfgwWfuxF
X-Gm-Message-State: AOJu0YwyCo+glFVaEp4oitRQDpkyqYItwt1aPxVBv64NhREJtl2suXOA
	um66E2B7L9q2+pxyT/uq9D4wDvo3uldasM8GVjQYttOQpqSKzbUKBbcWHGnht/g=
X-Google-Smtp-Source: AGHT+IHvhGIL9bagwIEIWKklEMO2niJwNdydUNxk7jfjMiblsReyAbr8xDnjx9dhW5olJB7JFIJNmA==
X-Received: by 2002:a05:6512:158c:b0:52b:98ab:6100 with SMTP id 2adb3069b0e04-52b98ab619dmr2154272e87.15.1717403144788;
        Mon, 03 Jun 2024 01:25:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:5b1:48e9:27a3:7085])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b84be78sm108641565e9.17.2024.06.03.01.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 01:25:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: alexander.stein@ew.tq-group.com,
	krzk+dt@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	brgl@bgdev.pl,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linus.walleij@linaro.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: gpio: mpc8xxx: Convert to yaml format
Date: Mon,  3 Jun 2024 10:25:43 +0200
Message-ID: <171740314108.11298.15004161310238771393.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531164357.1419858-1-Frank.Li@nxp.com>
References: <20240531164357.1419858-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 31 May 2024 12:43:57 -0400, Frank Li wrote:
> Convert binding doc from txt to yaml.
> 
> Remove redundated "gpio1: gpio@2300000" example.
> Add gpio-controller at example "gpio@1100".
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: mpc8xxx: Convert to yaml format
      commit: 77e1ea9e9913df8c23ac102c9c2b7c49a5d224da

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

