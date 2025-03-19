Return-Path: <linux-kernel+bounces-568174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51BA68F14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F12E882BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D97A1C5D4D;
	Wed, 19 Mar 2025 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVMkRvdc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855551C0DED;
	Wed, 19 Mar 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394370; cv=none; b=Zca4jjbq/Wu8npBOiQTf9M0h2o4E+5xfWx2IXO21yoOarr+XKH4O3Ep6OJGHDwnP3gYBFoCLMZGgNYYnDsAa2NwBnAXZb7UHXAK3/iJg0GYysNpTHtooQh22n2S2JCpD/2LVWRpDpDp8qisEsq3pDowEr9FvUf7nC8Wn2vIRcbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394370; c=relaxed/simple;
	bh=u9ne6noAROmIUk8hyjXM3BCGrOUF6I4+E9guqT83c0E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PmbCea2gIQLGBkH2md6LYQrAp4pyH+LmatVezCMOHAlBQTLUHHIMQrNHEjWBdNlrA/HSP79BhH+AhbTjokwJ7K6LG5JgPQRTRsQZz82zEmf6yVMCvlddRBT6JsVuQ5IlpxWH4KOY3h4BF/l5SGc7OiHTzUU7JvhDCSfAs7FRZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVMkRvdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D58C4CEE8;
	Wed, 19 Mar 2025 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742394370;
	bh=u9ne6noAROmIUk8hyjXM3BCGrOUF6I4+E9guqT83c0E=;
	h=From:Subject:Date:To:Cc:From;
	b=DVMkRvdcIvo0uon19WFzAlpe9JfyUtncBdpV55n1daiB9gIhrYVn3jEj+muKqJqYM
	 8QyRWuqg/raggyUao3R3uzSC9S/vFSXuZE37ZMecirv0ksJ/zwWNCDvrqvCrZQ/Ll4
	 TblYXLtlFu5ixuR3JWFqvZodF0YrdbzCI27aHTzZxT8hgPFKlZIBs3LRpE9f2JKdqn
	 Tdhx3YI46/UkDKJwL0V40sT21u8HncjanTaU9OhJJbXoYV6wchW7p+Y9mO1qNROmVP
	 CR0tx9gm9f0QypCbSs+HUAu1pvCSEwNibsAQ/6jgDmAfCbpBr8VolrYXGGJGrFsRHa
	 HC0aa+gjGttvg==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/2] Allow 'nonposted-mmio' on single devices
Date: Wed, 19 Mar 2025 15:25:56 +0100
Message-Id: <20250319-topic-nonposted_mmio-v1-0-dfb886fbd15f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPTT2mcC/x3MQQqAIBBA0avErBO0wUVdJSJCp5pFjqhEIN09a
 fkW/1fIlJgyTF2FRDdnltBg+g7cuYWDFPtmGPRgNRqrikR2KkiIkgv59bpYlMURN/SkPVpoaUy
 08/Nv5+V9P85vLpxmAAAA
X-Change-ID: 20250315-topic-nonposted_mmio-5393a3de0d35
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Melody Olvera <quic_molvera@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742394367; l=1084;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=u9ne6noAROmIUk8hyjXM3BCGrOUF6I4+E9guqT83c0E=;
 b=MFfiScu79U8kKeCNQrQjgsC/rDpanH0ypvf2lLeiZLcP/VQKaj/61zfckwPL7ek90C9AO2Cob
 cr5xxCcm40UCXgxvdRJJjdlHF6KMk8xTVPxn9Yj5xtY/8fndGrQGtwl
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

For a plethora of reasons, usually not very pretty, a single device on
a given bus/platform may require a different type of memory mapping.

With nonposted-mmio specifically, we want to limit the scope of setting
it where it's not necessary, so as not to shoot ourselves in the foot
in the performance department.

This series allows mapping a single device as nE on arm64.
A user will be sent separately, as a new node for a QC platform.

The dt-bindings part is handled in the checker itself, see the following:
https://github.com/devicetree-org/dt-schema/pull/156

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (2):
      of: address: Expand nonposted-mmio to non-Apple Silicon platforms
      of: address: Allow to specify nonposted-mmio per-device

 drivers/of/address.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)
---
base-commit: c4d4884b67802c41fd67399747165d65c770621a
change-id: 20250315-topic-nonposted_mmio-5393a3de0d35

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


