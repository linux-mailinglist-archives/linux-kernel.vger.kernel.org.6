Return-Path: <linux-kernel+bounces-434551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FC99E682B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE05168E08
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFAB1DF743;
	Fri,  6 Dec 2024 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy5oQh4A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791501DDC38;
	Fri,  6 Dec 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471218; cv=none; b=fMzhrNICpX5iNHiSkmPu0pZzR6aZuz+e1F/ddwoLvcOVhwnGECu7GYd7rmrbLKd5qGOYHBbbpPaZduk+DJUFiBHUqGb0xjaeJy7EqOEsn1eSDCPTqix0/UbxMEwTJfF6cuVI49JkZ4Wc76VcT+lkNma2Cw/5/MESPKh0MymX5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471218; c=relaxed/simple;
	bh=rIuOPSZ3vHFGNWi/6Cw75i5UpoJ+Y1ASP/eaOjNNLBM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g/FICHEKSy1uXM1u4b48ESnwtOFMhd6CkaQ4cPylqP434u0pcVCbh4/Z5M3eKGwfszTRqjA4YatkwLM0xmX9kowLakz0NZwKAj0wrP/adIMpVS1uBdtRX8RHzFPO07il3/TdbjMYMbOlvgi13cxXT3knIxSsVm5txbhODO1PCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy5oQh4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00BD3C4CEDE;
	Fri,  6 Dec 2024 07:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733471218;
	bh=rIuOPSZ3vHFGNWi/6Cw75i5UpoJ+Y1ASP/eaOjNNLBM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Zy5oQh4ABy9TlOL/KeAq8Y4H6+4MA1gkYH8gIcHq0K+Nm7fn46LqlyHnmiqSTcFis
	 rW7618qKeXh7gefhNXB7xeGLx2bfrZ/ea3PpaMKIsvF9NNFYIze4OMmR0Q5TRhbngw
	 GcjB1pWSoSmfcDRAq/PhbeXHiX4lMeHCydzhdHu1VWDVOqsy4zcGUnSAo4xmuQAphK
	 f5Taib2qplWEDu04ZQfRkB7/EB1T9Xyyh4vP6G0Sg3f5sJ54L5faNFQMrcVuI96qH1
	 EYnO7AJFlQAlcOjnxdfvhVqS+imsAyr7lkfkBMevK5kyAr6m6Vp5n0BjMII9Y2ZxfM
	 9gR2Xgha3L6Tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E880BE77173;
	Fri,  6 Dec 2024 07:46:57 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH 0/3] Add support for responding to Get_Revision request
Date: Thu, 05 Dec 2024 23:46:07 -0800
Message-Id: <20241205-get_rev_upstream-v1-0-90158ee7d75f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL+rUmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNT3fTUknigwvjSguKSotTEXF2zJDMDIDAzNkhMUwJqKyhKTcusABs
 ZHVtbCwAxUc9OYgAAAA==
X-Change-ID: 20241205-get_rev_upstream-6b60000630af
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Kyle Tso <kyletso@google.com>, RD Babiera <rdbabiera@google.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733471217; l=1144;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=rIuOPSZ3vHFGNWi/6Cw75i5UpoJ+Y1ASP/eaOjNNLBM=;
 b=YKIez4YBYfYYsJa+1AFtSUFmhxjiYGDNbHUnDHgje5A92QwKJb1MDUDHicgLm/fG50ZXNaFKO
 hWZgAPclbrjA6EW8y4PTa5t4ewhu1cFc7i5+UUVEribllXSFCzKP63M
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

Currently TCPM doesn't support responding to Get_Revision request
message. However, as per Message Applicability in USB PD Spec 3.1 v1.8
("6.13.2 Applicability of Data Messages") "Revision" is a Normative
(compulsory) message and needs to be supported. As part of this patchset
add support for responding to Get_Revision requests as part of
Revision_Information AMS.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
Amit Sunil Dhamne (3):
      dt-bindings: connector: Add pd-revision property
      usb: typec: tcpm: Add support for parsing pd-revision DT property
      usb: typec: tcpm: Add new AMS for Get_Revision response

 .../bindings/connector/usb-connector.yaml          |  6 ++
 .../devicetree/bindings/usb/maxim,max33359.yaml    |  1 +
 drivers/usb/typec/tcpm/tcpm.c                      | 87 +++++++++++++++++++++-
 include/linux/usb/pd.h                             | 22 +++++-
 4 files changed, 111 insertions(+), 5 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241205-get_rev_upstream-6b60000630af

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



