Return-Path: <linux-kernel+bounces-173111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988A18BFBA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374F61F22937
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1881ABE;
	Wed,  8 May 2024 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VBSvWMAq"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAF181ABA
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166971; cv=none; b=GjqQE59mP5huywv8tcK5DQuwnQnCA1lSWncb5CQNbSANckzbIvVAlZUnMsCBWBchYBcUDvNAYNF4VFcV1Aoc8akadkOhtEOCzlxdCrEtsrN1GvZLW3SkvuwOYs/WcgbCjqAxDsluMa0+TD6yX5t1ggHkQbLv8NLiNF6+mu2/cPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166971; c=relaxed/simple;
	bh=n5syDHbWlKZFGlbFdFRj7DVmAEgeHOc88URkxEey/2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fsxJmnyaM9y3dAmqSqo87gLpmTVAAekHMR25I2Fc/HndjRuWB8yTorG5z8BAr6vdepV+5r8cMK1W0vM67vU6uWJu+vpJ1hUeo7Bk9AJAqdcdQzgbUsXkEh29N2BnUUHtyzcAg/+WbSxCS+PsLZB8G+C/NEw4+kZUH9EOmFS3WaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VBSvWMAq; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8791D3F5F4
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715166967;
	bh=ttExS1UnS2n/6Qa/JbmhsWywiSSPxbOTQjuITk/gJkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=VBSvWMAqZNIczhVhmATL0ddvXieeexQtAVda9DDyaCwBiME+F1IBKO251J0cD0loS
	 obVIsTkqNg80UV5bX5ANvgoOyCPMrx5pfa42iCk/PmQPn5eVrVHz6TVMxgwkme9EQi
	 YoNwTXzOMrq27Supoyrt2q3ndEBFR2aL4VfniCgo7dKIIvYwxGoqYXQL3POKwbLcpi
	 Xk/DjE1VFxMb85vYqtB90oUqWkyMMokD7bAHfSOoeZKc18lXNBi54BrJVqVY8Uys6m
	 vlshjVID34G5yvOU1SmhJbnBKUsld7EJqKbmPCiRmoxldnF9MSEI1rxBISYchay8rv
	 IDTMsrVB/tIMQ==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57268a481bbso2285659a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715166966; x=1715771766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttExS1UnS2n/6Qa/JbmhsWywiSSPxbOTQjuITk/gJkg=;
        b=fzZ4oy+1jstAJXvC2hAfsPEzf8tfZ1JQqYE5PifQbieEGTOfYTITjnQlhiPSJ9OnEC
         DXpa9CZXNyw9QPv5VVKWKn2nrN8AKS5ve+i6ARqKL9nyCbQhs/Dn+p5G69VTbQJnbv/q
         3n8H+7CpYdFcg4xmlSAdrnb9pGz0lUKjj5/VgdrjYTuETrnT1Rfj/ffpQBsrrEb9w1vt
         sLLK8R24LepATDh4rzt/dNxf4JAfN/Gij+DHIpLoEaNV384AvC9QE5w/kZDCgLuXZBK+
         l9vITWU99Af0LSKnMJim+nVmlb94CbXO7UK/PSjbgPdXPDcb+Ihgpn/IxyqgaFlECO+R
         xzbw==
X-Forwarded-Encrypted: i=1; AJvYcCXvp6TgbmY3lIwUe6S0kr6B9k6WkLdwkCZQFP2JqKbUA2aUTBAfipDylxKH2njU1oJR8sGIcbwb2TfqojVANauSn087YDswZ3yHz3dS
X-Gm-Message-State: AOJu0Yywue6h5rqk+0fJh44Nk3HdRakiK+PeHeFP7gwZTUZFjAUagLtx
	oCy4c3958U+6iA5x0LTAQ259/Hui3dfuF1YCxj20iBcuzLjAmEOkeuqCgZDPP7LmIPcFWedu9BU
	reQkDjAtxYDmv/2RLGdBJoCnvztcHxgeGW23G6OufUlwpOspfBkShZGmXueF/5RS7hh8ASfCTPo
	IXKg==
X-Received: by 2002:a50:c04b:0:b0:570:cd6:8ef with SMTP id 4fb4d7f45d1cf-5731da68e1cmr1841380a12.29.1715166966627;
        Wed, 08 May 2024 04:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/zJKBlzUpmhPRWq2mnEwWWSWQxatndRrGKIq4OblBhRgcWleGjKshrbRBqa4BNQ8dbb/k+w==
X-Received: by 2002:a50:c04b:0:b0:570:cd6:8ef with SMTP id 4fb4d7f45d1cf-5731da68e1cmr1841369a12.29.1715166966301;
        Wed, 08 May 2024 04:16:06 -0700 (PDT)
Received: from stitch.. ([2a01:4262:1ab:c:8ce6:9eb:cd7b:fcdd])
        by smtp.gmail.com with ESMTPSA id co22-20020a0564020c1600b00572a865af10sm7513556edb.44.2024.05.08.04.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:16:06 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v1 0/2] riscv: dts: starfive: Enable Bluetooth on JH7100 boards
Date: Wed,  8 May 2024 13:15:53 +0200
Message-ID: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables the in-kernel Bluetooth driver to work with the
Broadcom Wifi/Bluetooth module on the BeagleV Starlight and StarFive
VisionFive V1 boards.

Previously Bluetooth only worked with some GPIO twiddling and a custom
program to load firmware from userspace.

Emil Renner Berthing (2):
  riscv: dts: starfive: Add JH7100 high speed UARTs
  riscv: dts: starfive: Enable Bluetooth on JH7100 boards

 .../boot/dts/starfive/jh7100-common.dtsi      | 49 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7100.dtsi      | 26 ++++++++++
 2 files changed, 75 insertions(+)

-- 
2.43.0


