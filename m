Return-Path: <linux-kernel+bounces-331552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41E97AE34
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2751C2368C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293AB173332;
	Tue, 17 Sep 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="KYcTdRZG"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880A17554A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566508; cv=none; b=o74QHMAxn8u/i4SF4EiWXRDqlfYoXrFP3na5e/SrXuTynH6MgJl6QMNzYnnjRQAnrOR95FVWSD/UpGwWihLf9clXW2inomiuLarb5GtcRpV+K0tDS081m9U0BWT/u4OOPFignnRsn3LP9MqJIZDzSaUEwHaevcaIpC2e39r+rFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566508; c=relaxed/simple;
	bh=E3PhI7GXCpAJdmzT2a4iNhDJzEoJFoIPGeg0EuOfq7w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iZglEPKBI03XazXULPGi00f+6sqFiu97hXtd5AoW6MELiIT+eGwKtY2s7H+4XM39XqINMyEWWifDMyrsi/dKTnyqnrOx2rJd77PJigHa3p8xpVFFDYvD5uMb5UQ1eSORt1xb+ewjAL/KIyO/fis41kifmJDFbKD/z6g9jcmaef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=KYcTdRZG; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1726566172;
	bh=E3PhI7GXCpAJdmzT2a4iNhDJzEoJFoIPGeg0EuOfq7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYcTdRZG+7mGj7p6ZQZhXdMvoHqD5xgLqHs7kYRf4Hu7OPS/TZvf9JXa1ug9T0bkR
	 w2mcva1kyZ1zZ2mq9YRjFuoseQx2tS01XjtRjeMwKLmyvJ8BxWIBHWQBu2w8v82BIj
	 CNLKnJtFMqiJHVTfyiNdFQuoUxdfm1ZQEXI8eu+4=
Received: from localhost.localdomain ([171.223.88.248])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 75C3E8BE; Tue, 17 Sep 2024 17:29:28 +0800
X-QQ-mid: xmsmtpt1726565368tyrem4zbq
Message-ID: <tencent_A24F6B829322C51ACE3AAD2A496AB0B16608@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9UtifDk/jJniBY8RKeaI9sKcbjuN610V7gSEFfK6wBzGpflnYVB
	 V/6AdePo7ncYeCnMDnaESBdtvmQquIJSso3j3np/0X0HyJGqpGRW0D2CtFNac+j0+pkhhHGs6/ZX
	 IeceYG2Yvmzf+vr7DxjYjbAhHOxE7u5dqFHuszCG30bvnfdC+yjYKtlfSRoO8Gq6H6Vi7Fly/mP8
	 TfVQiIbxyT1Ek5Dwgcghoo1uyf4igg922et+BskjVIoItEH/QWk9MNfH2BFXOzHpog26qzfHpBU+
	 SWL2Mr+FJWjAbxXD53NJR3SjIjvnAo0pQqZUT5JirLPyKTinN9MAFVxsojNHfNkgORmdCIaZSbpV
	 Y0q0bv0iN3xQpQRFuqZ+tmrd9jOFdzmSY59bVnG9H1Y5dYIqdyA4mvpyYwgHrBPukioT4U3dpSGQ
	 cWPOIBTWIm0I/gkZVgUAq8AsduYJIkt4A8JpmsfmWnoaIYddMi+5UZFkPDMirUOmac+hJo00vjK6
	 3RgQBdA7TCsKXqqYGrt3wukCjBXmkRp4cPEJgMehHIspPSBEXkRNAy/lBiKtolxSeIUbMORf/gkP
	 8yH/BJI/v/SoQi0dHWjuiAx1ZJXUbpBfcv63UTB6fEW+Sl5MFKIfcT3EEb+HlKMtm6aZ3akGue5T
	 MAtRdiseYPGmnYhd7f3DOwoBBLRHFwLSg36W7ygjSX/PU6/rdfUHuLeltaFSn7ilJ97TI8HXqXsd
	 QsmhQ3rA4C2hJVnlaFMKjKXjIYwVrXjXR9OquEk8Rv5/LjhxNAV0G56IL10FlffAYUPwfamEeGF7
	 uJi+L3vpkm3yL2Y5deaddM14XLBTOPTNJyGklJdm92JE8rv6zfgQeSG48DGN8nYDNPT9NK7m+Sng
	 YtyyyzwuY0ta5qUs16pH3YzSE4KuhPENCE1GwZSUkCOEtuv+/hVuc1cJsAuJCjrb3ukUjX5Q2ey4
	 llCjHjAlYyk7EKbvV65vy2m+zVKS4E4Fs0YH2Cup+pyIyQtqVVGIUbFAXDZpmIEAJJOokY2VXfXT
	 ILW29MvQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Renjun Wang <renjunw0@foxmail.com>
To: christophe.jaillet@wanadoo.fr
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	mwalle@kernel.org,
	pratyush@kernel.org,
	renjunw0@foxmail.com,
	richard@nod.at,
	tudor.ambarus@linaro.org,
	vigneshr@ti.com
Subject: Re: [PATCH] mtd: spi-nor: Add support for gd25 and gd55 series chips. 
Date: Tue, 17 Sep 2024 17:29:22 +0800
X-OQ-MSGID: <20240917092922.4840-1-renjunw0@foxmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <47e0745c-e7a4-4201-b1bf-bb8e44e5911d@wanadoo.fr>
References: <47e0745c-e7a4-4201-b1bf-bb8e44e5911d@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Best Regards


