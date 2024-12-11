Return-Path: <linux-kernel+bounces-440682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870789EC2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF0B1882C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C3E20A5E4;
	Wed, 11 Dec 2024 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpzG/ymu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3FE1FECA0;
	Wed, 11 Dec 2024 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886446; cv=none; b=CLW4Tz2mcsKL1tmpQArovkLJgigGcKr/KhzTnc8un4BfGNmCzNdyPPol/u4q5htTklQOHo4uU6N7rzoO5CNkOI3Lsg1nEMYxXNoqZilcZwj9qZhLIBLI24FBvm2Wv9G2hcDr5RMnYPJFXu0w/K/QlWzD06KXBKQpOOdfGauF0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886446; c=relaxed/simple;
	bh=CEwUdYH0nCr9FSjB3Vc7SkwELpFgK6Eq00uXcIMkpiM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ks+C3ZzAHWqoK7iOwQqDASSNZTXMHYgxydkQPGmeaAJCrNDf+eP7bQU+QxXvhm/omY2WKTyxZl38kYGlNCV/ig8FQxS0t1XZJaKFOw9N2lB9VFBZ1lSB2S+6fHWRDuS4p5oqtfQetMnQsSbjk0GBpuJM1h46LMsrs6UxWrMpZ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpzG/ymu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D178C4CED6;
	Wed, 11 Dec 2024 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886445;
	bh=CEwUdYH0nCr9FSjB3Vc7SkwELpFgK6Eq00uXcIMkpiM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MpzG/ymucHJoGU1OFLMgsZiilcgUzrksPj6+cgIgjUuq3diZ8Ddod//l9TBR4MqN0
	 rhUvpzp6uyEjZhYSNXVsQpV5A57+Z7T/BokVQbD8A6wK70+rVXLY4VRKXnV6SrhSjt
	 /U/B6LTAFyTS7U5yNsaWAMdqRCivYlc789VTvZ9XP0zuWMt3kX3TAc1JLDyXNvn+9w
	 c8pJa33mdO6t9wT6QyGAIBR0xOgUnmRLYsXheq1XvSazdpnaa4QlwdabexMgolVm0Q
	 0RYmMOpRbsJ/eW6qEbNzen7sipro8g645dSAG8A2jDlwGBF28mhf1AfhX/DxcpjNFS
	 K7v4a+a9/ArVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C17EE7717F;
	Wed, 11 Dec 2024 03:07:25 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH v2 0/3] Add support for responding to Get_Revision request
Date: Tue, 10 Dec 2024 19:07:06 -0800
Message-Id: <20241210-get_rev_upstream-v2-0-d0094e52d48f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANoBWWcC/32NTQ7CIBCFr9LMWsyAlmpX3sM0DbYDJbGlASSah
 ruLPYBv9728nw0CeUsB2moDT8kG65YC4lDBMKnFELNjYRAozlxgzQzFvgT71xqiJzUz+ZBYJE+
 oNJTa6knb9z557wpPNkTnP/tD4j/3z1jiDNkVeX0hasam1jfjnHnScXAzdDnnL/C4TpKxAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733886444; l=1318;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=CEwUdYH0nCr9FSjB3Vc7SkwELpFgK6Eq00uXcIMkpiM=;
 b=NZyEywntSJaRNYEZgJ8E1nGOMQ+NnCFvACWapkVOKgSHnikaWWYbndwYepCoL4hFEpOZ6EbpJ
 X+zZYEYLd6mCY2VY+ChM5709KSmPLyIzVgxByByztlHn5EoHhA/6+a+
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
Changes in v2:
- Added maxItems constraint to "pd-revision" property
- Link to v1: https://lore.kernel.org/r/20241205-get_rev_upstream-v1-0-90158ee7d75f@google.com

---
Amit Sunil Dhamne (3):
      dt-bindings: connector: Add pd-revision property
      usb: typec: tcpm: Add support for parsing pd-revision DT property
      usb: typec: tcpm: Add new AMS for Get_Revision response

 .../bindings/connector/usb-connector.yaml          |  7 ++
 .../devicetree/bindings/usb/maxim,max33359.yaml    |  1 +
 drivers/usb/typec/tcpm/tcpm.c                      | 87 +++++++++++++++++++++-
 include/linux/usb/pd.h                             | 22 +++++-
 4 files changed, 112 insertions(+), 5 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241205-get_rev_upstream-6b60000630af

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



