Return-Path: <linux-kernel+bounces-553117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E81A58416
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6136E169BFC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8741D63EF;
	Sun,  9 Mar 2025 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgfRWsIU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC540849;
	Sun,  9 Mar 2025 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741523985; cv=none; b=jtqjxnNgXXm7h2qv71+oxKYA0953TWNH/7N63dDe1BWzTxJo4cf2qNQEv8cdKd8FAnXwWhttTkmd28vv69HU6lu07l5yBkAdnqp11F7mEKVj745P7ZsACHrSoKFyijNyoW3g0DU0pVhFjwjQg4KOcP7IeESeif4N+DIR2jayf5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741523985; c=relaxed/simple;
	bh=lWl5lYord8cuB5ZzfLS6JRfbOoN/JMaoXnsGUHvSaGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q2XHzgekyZcfI8NIhTQ9ynNO8RxpdJxFCAwPeizm98df+zskMKZlehiiqprgwQb2iClxvETNZQ6VRQixXf6Hi0X1DdCpAW/60JUVjOBNbSGhRVcwie37u9z0QiGODxg8cILyEhqJtCN3bjNXBiEL8EynOAUQc/BkF7Lnol3Ctc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgfRWsIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6175FC4CEE5;
	Sun,  9 Mar 2025 12:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741523984;
	bh=lWl5lYord8cuB5ZzfLS6JRfbOoN/JMaoXnsGUHvSaGI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=bgfRWsIUMV70Z7mSZTYp6dYX+Nu0x7I6acmsohXuLMBoS9N0MJkSUEXwyhdsy7zO1
	 VuLda67M91B31NqAU/RXeyUOlVFC6tA3oLnjr0Y/49hVGuzJYxfvK3gMBs198/m9RQ
	 fuExHprQ2Uk/gju4rSahrAkOFPoMZlFOAnw+LHqnzPP01CAAqtziO++SGr2FHJ1dHD
	 IAKmpfNj7j9K6DmObNvxAHVs+X5dB4WEupANow29TPz5yB8hp2Ft9uPDOAeLdIb+sY
	 Jll9FSaXWPKl8HzgJYHdk+rqnBlpvwJqUUhp3fQR7YqhWR4MLMsTCVJpjJynJrzSn/
	 PuwcpN6sWHMTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DD3C28B25;
	Sun,  9 Mar 2025 12:39:44 +0000 (UTC)
From: "Chester A. Unal via B4 Relay" <devnull+chester.a.unal.arinc9.com@kernel.org>
Date: Sun, 09 Mar 2025 12:39:36 +0000
Subject: [PATCH] ALSA: hda/realtek: Limit Internal Microphone boost for
 ALC3246
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-for-sound-alc256-dell-v1-1-aacd84853907@arinc9.com>
X-B4-Tracking: v=1; b=H4sIAAeMzWcC/x3MQQrDIBBA0avIrDtgTDW1VwlZiI7NgGhREgKSu
 1e6fIv/OzSqTA3eokOlkxuXPDA9BPjd5Q8hh2FQUmk5yxfGUrGVIwd0ySttMFBKaCZrlmitp6e
 G0X4rRb7+33W77x+M9elUZwAAAA==
X-Change-ID: 20250308-for-sound-alc256-dell-61967f99ce45
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Kailang Yang <kailang@realtek.com>, 
 Stefan Binding <sbinding@opensource.cirrus.com>, 
 Simon Trimmer <simont@opensource.cirrus.com>, 
 Joshua Grisham <josh@joshuagrisham.com>
Cc: alexander.scholten@xpedite-tech.com, dwayne.dupreez@xpedite-tech.com, 
 zenon@xpedite-tech.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Chester A. Unal" <chester.a.unal@arinc9.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741523982; l=3467;
 i=chester.a.unal@arinc9.com; s=arinc9; h=from:subject:message-id;
 bh=6CDVT2SLeMufNzb6wH1khK6tsAEt+ToJ1Hx6kvFEPZs=;
 b=RjzqhlLgi4pwA4YjdKCIz/HMB6cBnKGtclU9g6cSTRfB9RbgpDMgC/y+bJSUKs3jvW4P7PcwI
 RUJhN/ob/RZBqerIWNCzYZDzEXBhZhPcQJGv2nv+fTUY1l1+yC7IWti
X-Developer-Key: i=chester.a.unal@arinc9.com; a=ed25519;
 pk=/g3vBAV0YSvcIpSQ052xJbid7nrPXz8ExGKhTEuc6IY=
X-Endpoint-Received: by B4 Relay for chester.a.unal@arinc9.com/arinc9 with
 auth_id=306
X-Original-From: "Chester A. Unal" <chester.a.unal@arinc9.com>
Reply-To: chester.a.unal@arinc9.com

From: "Chester A. Unal" <chester.a.unal@arinc9.com>

Internal Microphone is too loud on Dell Latitude 5490, Dell Device
[1028:0816], which has got ALC3246. I suppose this is the case for all
devices with ALC3246 which is ALC256 for Dell devices. Therefore, limit the
Internal Microphone boost for ALC3246. Change
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE to
ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST which includes the former fixup.

Signed-off-by: Chester A. Unal <chester.a.unal@arinc9.com>
---
I don't know ALSA or the Intel HDA specification very well so feel free to
correct any incorrect information in the patch log.

I experience another issue with this laptop that is also there on ALC3204.
Headphones output loops back to Headset Microphone. So if I record with
this microphone, sysystem audio is recorded as well. I have tried a fair
share of fixups by compiling snd-hda-codec-realtek.ko with different fixups
applied for "0x10ec0256, 0x1028", replacing the existing module in
/lib/modules, and then rebooting.

ALC2XX_FIXUP_HEADSET_MIC makes Headset Microphone appear unplugged. But I
can see on the OS that it detects voice, so, it works. When it appears
unplugged, Headphones output won't loop back to it. This fixup also makes
Speakers appear unavailable and makes Microphone disappear, as
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE won't apply anymore.

Another issue is when I toggle capture on Headphone Mic on alsamixer,
physically no audio will be played on Headphone. Speaker is unaffected. If
the capture is toggled on anything else, Headphone will play audio.

Tested on Debian Trixie Alpha, kernel 6.12.17. My headphones are
Tip-Ring-Ring-Sleeve. Here's how I test both issues:

systemctl --user stop pipewire.socket && systemctl --user stop pipewire
alsamixer -c 0

speaker-test -Dhw:0,0 -c2 -r48000 -FS16_LE -t sine

arecord -Dhw:0,0 -c2 -r48000 -fS16_LE -d30 test.wav
aplay -Dhw:0,0 test.wav

Attached is test.wav. The timeline of the recording is:
- I run speaker-test. Then I run arecord. After that I say: Speaker-test is
  running. Capture is toggled on Headphone Mic.
- After about five seconds I say: I am switching capture to Headset Mic.
- I toggle capture on Headset Mic. After that I say: This is Headset Mic.
- I kill speaker-test. After that I say: I have killed speaker-test.

Maintainers, please let me know if you have an idea how to fix these two
issues.

Chester A.
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d2a1f836dbbf714c26be682133b44cc0bd173ad9..379a325e96641232485a2fc8e6de03798461f466 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11799,7 +11799,7 @@ static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
-	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,

---
base-commit: b7c90e3e717abff6fe06445b98be306b732bbd2b
change-id: 20250308-for-sound-alc256-dell-61967f99ce45

Best regards,
-- 
Chester A. Unal <chester.a.unal@arinc9.com>



