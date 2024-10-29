Return-Path: <linux-kernel+bounces-387746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28D9B5599
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9DB1F240D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243AD20A5F3;
	Tue, 29 Oct 2024 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jschaer.ch header.i=@jschaer.ch header.b="pUPq261l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nSHMtr2G"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2E4DA03;
	Tue, 29 Oct 2024 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240034; cv=none; b=EF39D0lDYcUwroxLiZrcFtQFbfWIDckLSKYmK00JRN6hA27PLfNJ1LFMPSkPKfeFAnkHHc8Vkl6Df+HDAFwYYny8h6J6kOrTQ0HaXXAP0yOS1L64IROlCziGHjEsH50S+QhLA56BJbeNiiOP3HMl8EVqQp4yFN9fsbncOgHKNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240034; c=relaxed/simple;
	bh=rmDG1//6yBuFI5nKR7yoJjw3Pamwhqf8C8NM9xA+QpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=d7PnnZkzX1fbfXudtohV0/c4jWGsy51L6zyIH2glCnQeVC0HrQqtnvz1sw+Cs2eTZoy0F8j5a3WtIAyRcdeMZBhWUqWHeM8kY8h28wJjdDxyMP1glihdMnNsd8bTNamW/TiViQFjBFrsHvEoLvvZwtzqf9Ltz4S5wq7ocStEMkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jschaer.ch; spf=pass smtp.mailfrom=jschaer.ch; dkim=pass (2048-bit key) header.d=jschaer.ch header.i=@jschaer.ch header.b=pUPq261l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nSHMtr2G; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jschaer.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jschaer.ch
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8898D11401E5;
	Tue, 29 Oct 2024 18:13:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 29 Oct 2024 18:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jschaer.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1730240030; x=1730326430; bh=KP
	cJEhulemEQxkhyMekvyHf5hCr+l5XSqwkpJLdIrE8=; b=pUPq261la7EQRN2v3L
	ROVu/pr8q5TllkI9jjnYx6XvCiXLIwPS/lrTgQu93XazNYEyEYep15L30bt1c4vK
	550K/WFxLtTslZbRvsRs9bguOLzzS9ESPdu3EYnsdEVeRVq7VUKZuzH8QL4XdI6e
	CMozEnHHiB3FZmLyLe6KtKwL3P+JJZVvkCbNN/QK6sp1NhACPdPY4rXhsP+JpbnT
	fNAEXyUhedfktPHgt2uYgfeaoL5dlHb7sO3pmTe2LML7zzc4X+nnltY5VM0gZxCg
	6oQreBdcP5sK+O3f5YptlqlBcKnvepk9LmDkaZpmkg3LAJte/u+74gToCWV+TVjj
	yaMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730240030; x=1730326430; bh=KPcJEhulemEQxkhyMekvyHf5hCr+
	l5XSqwkpJLdIrE8=; b=nSHMtr2GGF8BmmKFQjPOzuYIoVJCQZ9edix0e6tsnkWX
	jhPlcZVwV9V3ybeROsqo+KczNZOXyR3tBvzBnTsLdwsQmsS2PpbSHVSeWBpJkS2v
	IfkztTKM549KvCXMeE80NnWuB7b3JoOe8XEZLzxQqxIptr3arQmIW1GfZDwd2t5F
	I4jSjxe0mWBUiNi33FCwASgCmUgfiQ+PJ1DaXlZcLDEa2dMrJEgpuu2TrqPy2Wu4
	phibNaxLtKfEnFAva52T3Y4/3XXc+qaTmChMt41CQp7JlvA7F2Gzcax+n1K8ZcOW
	TIwYIyeoNP7Gx4rtMUMwOi4Gdmj3P8xYdbNTK22FVg==
X-ME-Sender: <xms:HV4hZ8G49qTZH9V09UYc0qcBUVuxcndNOiGSe5Jrt2Vg_o4fcT2eMQ>
    <xme:HV4hZ1Us7N4xrM3Z4mCLU-ijzM9ZN1BIxkjysJpqlVmPKvZFt4mlq_8cI3OKA_mFi
    s_sHhM92T3E0nxaLnc>
X-ME-Received: <xmr:HV4hZ2KWH6Z9AdJwg7qc7_d7Dut4RM-KrMkalD6jIdDu8-gSJWpcrQvy2itNTYSgvqqAkCQvaBxH-i6oAAe0WwuZr0QK9wt3xi2VZ0HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeen
    ucfhrhhomheplfgrnhcuufgthhomrhcuoehjrghnsehjshgthhgrvghrrdgthheqnecugg
    ftrfgrthhtvghrnhepheeifeegfffghfffueejueeljeefvedvleefieffhfejleeggeei
    ffffffffteelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhgrnhesjhhstghhrggvrhdrtghhpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghrvgigsehpvghrvgigrdgtiidprhgtphhtth
    hopehtihifrghisehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsohhunhgu
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrnhesjhhstghhrggv
    rhdrtghh
X-ME-Proxy: <xmx:HV4hZ-F_yv-ToGOfMWCNEPNjTM2_TvUEF2RjwPXwY1IR1jeElkm3Cg>
    <xmx:HV4hZyVdzBUKWICe30fmvHv3Q8vwFzMLjX2w5Q35ROCZ38H527B5xA>
    <xmx:HV4hZxODtVhqCLKksa9V7QbozdlShjHrcCIgHFqvecYyuJxhqH65GQ>
    <xmx:HV4hZ51yLZtzxVgzGdawuylXg5c4zGW56iR4y72edaklViOO24s2dg>
    <xmx:Hl4hZ0e7eKj7j_0jdcbGzdh9Gt16DbZdi700LnuCnWcd1CEV8ZAQ0WlH>
Feedback-ID: ie67446dc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 18:13:48 -0400 (EDT)
From: =?UTF-8?q?Jan=20Sch=C3=A4r?= <jan@jschaer.ch>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jan=20Sch=C3=A4r?= <jan@jschaer.ch>
Subject: [PATCH] ALSA: usb-audio: Add quirks for Dell WD19 dock
Date: Tue, 29 Oct 2024 23:12:49 +0100
Message-Id: <20241029221249.15661-1-jan@jschaer.ch>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The WD19 family of docks has the same audio chipset as the WD15. This
change enables jack detection on the WD19.

We don't need the dell_dock_mixer_init quirk for the WD19. It is only
needed because of the dell_alc4020_map quirk for the WD15 in
mixer_maps.c, which disables the volume controls. Even for the WD15,
this quirk was apparently only needed when the dock firmware was not
updated.

Signed-off-by: Jan Schär <jan@jschaer.ch>
---
 sound/usb/mixer_quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 2a9594f34dac..6456e87e2f39 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4042,6 +4042,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 			break;
 		err = dell_dock_mixer_init(mixer);
 		break;
+	case USB_ID(0x0bda, 0x402e): /* Dell WD19 dock */
+		err = dell_dock_mixer_create(mixer);
+		break;
 
 	case USB_ID(0x2a39, 0x3fd2): /* RME ADI-2 Pro */
 	case USB_ID(0x2a39, 0x3fd3): /* RME ADI-2 DAC */

base-commit: 583e8f76410a5b7e0238426d8e6e1e1d2f4994b0
-- 
2.34.1


