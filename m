Return-Path: <linux-kernel+bounces-420200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7DD9D77A6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF48B28054
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722C7FBA2;
	Sun, 24 Nov 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O14rHKNV"
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E118B03;
	Sun, 24 Nov 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470310; cv=none; b=aBqW1JEBOhdJVOawym1NWvOH0/nWRag1voa7nudkF9RtpB1RGj0eE8fa8qTv8gsuR1fQ+Rl30SxjR+YtnrFFF3Z6iujgRevW245fd+H4JmraDdn08cJTwdnHC0HQlFm9Vjn2TR/rVMENu65V2DYGI4Eu0WB1ef/7MsQjl3zxl1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470310; c=relaxed/simple;
	bh=naozf7B+svGSZsTQ6gTWOETT7Tz1OxiscnzlD5eNm84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwLsYnMlCEfs+25NKWEqhYSih02UiEsL6fnw0PlIngQGZ8e+ejIsbBEVAAHC9A003JtY8KYNH+QrA1nNiBdST3g6fApQfwwLFuJB7kOs057UgvIUaVDI2CrqHrJdQ+ADvGmKQAIDNl3hszAY8+SBkkZNmnyFeaf1DWZUPn1WJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O14rHKNV; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7EA38C0005EA;
	Sun, 24 Nov 2024 09:45:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7EA38C0005EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1732470307;
	bh=naozf7B+svGSZsTQ6gTWOETT7Tz1OxiscnzlD5eNm84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O14rHKNVZFLIepu7TlBhUc/iugDhVfJBCdG7qn5Bnfcfin00XUBRfIxTGdZJ2GHyl
	 m4juPCBf0B4BaOSHylpdRWYmaO1ZWspksVb+tx11WsLeeP1bMRX/cqRVljcZDlpok4
	 0Hw2LkTGvooKRugYd0ijF+DLLtPGS7QyVQLilXTM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 21AD518041CAC6;
	Sun, 24 Nov 2024 09:45:07 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: broadcom: Remove unused and undocumented properties
Date: Sun, 24 Nov 2024 09:45:06 -0800
Message-ID: <20241124174506.716145-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115193854.3624123-1-robh@kernel.org>
References: <20241115193854.3624123-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri, 15 Nov 2024 13:38:53 -0600, "Rob Herring (Arm)" <robh@kernel.org> wrote:
> Remove properties which are both unused in the kernel and undocumented.
> Most likely they are leftovers from downstream.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

