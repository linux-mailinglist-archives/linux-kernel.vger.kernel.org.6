Return-Path: <linux-kernel+bounces-575085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC3A6ED5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD662188C9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1862528FC;
	Tue, 25 Mar 2025 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="cF5eATIL"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A0198A29
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742897685; cv=none; b=l7OcyQ/82TH9IFs3+e1cgxDHHl5j0m1MZiU8u6VUpEKaJCfRQXkoqnl22TbfzpmVakRYMeVvLEEShKvEtQNYP/wA5LDVvTB9WeCMDNUWaBwjGR1EdN0Qsm84F5wyG9V8QLGBYGivMx2RlTGAE95k1af5rJfUVCFjTsuHy1QfelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742897685; c=relaxed/simple;
	bh=jrnUZZgTwFTTf7k6a3ZwqdkQysxMPMKuCcMUjtA4GgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cccxNi2i7H79J/G5CWh4HoBCe3jNbUGZ2/A0FDKWVpHRffG/prT2YFKY6+8ILorGIBEu5Ljt8Mu5NFNfjS5nPJwe03Ot78BUrdBWTeqB5/ZD6EM864AiqbhxDzivh3wqlZpOHZEm5wfrSt1nFVcwj/H1jYBR8FVipOXpupH7Llk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=cF5eATIL; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742897666; x=1743502466; i=spasswolf@web.de;
	bh=Kn4O1C1m+v3TNP8fqKbb9jrEsMA83fWOmk+rFaDwuPc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cF5eATILJVTjHeDfUYomZwTQyOXH75trm2neTwsGb+Ii2ftqe8whl2bdZJcJGzqW
	 u8MMQTO+CoD4x9smEtvMPf6bzaX1AvpeAHhzh2aW0F9G7e9OnHb0kq0kdZnqW6zrq
	 nHjhL5UxRmN7rV7BqA9NOSCDrSNRvwlhQoYg7WoHhGdMJqpLJDzKDGgKld418zQTi
	 x0YY3BHzhAEveIG+uP9VUmDk9iwqdcfMuDjTonXrRWDThLuk2Z/C34Cpr7exazOtl
	 2govgLRM06lIffMN7C7/XcNfcck3pVNKmlajduNpcqko5+ba+N1p5l0XrXIFv5syR
	 cK9llQ/TdZO0c+vgJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Mo6O7-1tLGmn1JpT-00koyo; Tue, 25 Mar 2025 11:14:26 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Balbir Singh <balbirs@nvidia.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: RE: commit 7ffb791423c7 breaks steam game
Date: Tue, 25 Mar 2025 11:14:23 +0100
Message-ID: <20250325101424.4478-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: 634e77d7-4f3c-4d1a-8aa3-1978896f9bf2@amd.com
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SGxcBUha5iflKM8hzZwOrkwP0CO4z6rXyWXA0hg2dgGhN1A1yw6
 crz/7P/Pl/PK/774wZ8hqoYwIzu7OU++hQiLoOlEsDycXfuyfMBHzvPFJh/303dqFeELNR2
 2fpDAEmHc0uU0FvgGaGPT5hUQIL3MNXnWfssESsJDFIJjW/EOUSdaZS0mxILEgpnxCAnZqb
 SOqvM3Pi2DT2x5Im1lI+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SoAjOdVbYAA=;zblxxf0DeO9eZMftQS+pZIW+MWS
 fTgZ1Kv2lHgv8rhyLkfnW5xyhhtiO+lxhwMCTF7+ETk9mHZkg1SiSZAx2ZfUAsVMXu7iQ1RCB
 FicS7Sulz9RzQMu7TckNskWDlfqoTzcGFzernIiyN9sY6OTEJO7dZAijS6O5iOJeLrdyiZFtW
 19yOEHQwM8/EH3/tRehtEAQh43u4FBumyiMzGKMDFKrRLnMyiUrODXybRFYdPM+hfRm9E6dWs
 J2VNQLpfHj5JiQH4ZdVtZcc0Zj8g148Bniuhcdzfn/7UEBlcctH9/SCg9G/owBw45aPQIi9NZ
 kAHVo0xYgGT/NDMw/pv3nQelKADK/YWeIf9sMWGjdqc2zYK7csgvpL8sLlBWZxtAY6oOGZFmq
 6k7fZkj4EmSZM9k9pKLOiWSKUczEAequy9wpVAWNmONBKc0cDUQFd/Flu1olLiJpX9KnK50Rk
 x3+d0dsM+ObUr3JmMoveiVfATez+jtX+GO9GA44MJbqwBL5RYxqUUJxkDRkrIpEHp0mHq2QR7
 TyePji1FlAIXYvV3fFVRW5GSUAE+70VYvks+cowInx0CIdqc8phaIU3il25RFhK5y1qvjDu3O
 ktqXwiEPcQj7OY4SuvGEUlqkcddhtdPnxA2OFOSa+yTVfMRld2a4nwBJpPNSgZuS3FXMxY3up
 2orl496eT3rtBCNeSvtVkJOrV2T9XbXBwzPLll2r7w6QjVcJfgZMCJd5F8wGoXHZORohVdPnS
 od3fExZWG0JTbXtKbuEytZFgUJuCKGY7t6UwS1OmfSmx4UKEbLHm8WpEUFssV9R9XajQN8Ee1
 j6BlJzZ2ePhMpMV/vzQu6wPEXynMcKzWSPW7BsXr9LJzmDgUiC6G3uYXP+ouY5cxf3Hi4JcG3
 cxYRzqOet71iFfqC1+F5j74l88X+ABtBMVCFY8kmxkocOwr1HWp3SSp+8teDcoZ+sb/5gCpqN
 wuNOknPN3H+WU2t9J8pcXw0Resa1GFNwh6Kr2vtJCqJ4+WLZppRw1j6GIfCY97M+B3n/RiHpA
 BdBEfvLPAY7KiNyHyOtfKiWb1pIJm00hdrOPmmhkkxgkEEy/N2G8/dzPoceTjxw2XTNNylyyo
 BidQ6Wby0I9g1gRGY//uSR298k0d4/przQFdYjFRJZeUrmHfHY1Tj7ZnH/5NtCAsSeq3Ul8nt
 7TYTdatpGdqbMsAK5stlLAleyzXNPUAb3z2WCDsyrDxY7HM3aIpuvnbqixM9smkagp4LgRUNJ
 i34WNLd69pLUH6aVWZodEbMat86TemCmJJBeytlv2gwwS/5A213P0wp/3jFos5V5er3z5s7ng
 ZJdyA0MEHGrFGwN841KzJrh95e87p6aFPg/26fj3YDvvVEcREc5VklFSf6Vi1wlNSFTF9Sb+R
 Ff6F0Bzlh0RVtdOQqyBsIQ8ngj7DfbpA10dL7CqhB+Nfv21fMNrD+E1qnX4JSD+FTopd/PTsZ
 127qOq0v9Yo/wNGIPlwHRrQyJQog=

My /proc/iomem  contans two memory areas of 8G size which are
belonging to PCI 0000:03:00.0, one of the is the BAR reported by dmesg
[ 0.312692] [ T1] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdffffffff 6=
4bit pref]
the other one is "afe00000000-affffffffff : 0000:03:00.0" (in the case wit=
hout nokaslr) which shifts
to "3ffe00000000-3fffffffffff : 0000:03:00.0" in the case with nokaslr.

Here's /proc/iomem in the case without nokaslr:
00000000-00000fff : Reserved
00001000-0009ffff : System RAM
000a0000-000fffff : Reserved
  000a0000-000dffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-09bfefff : System RAM
09bff000-0a000fff : Reserved
0a001000-0a1fffff : System RAM
0a200000-0a20efff : ACPI Non-volatile Storage
0a20f000-e62edfff : System RAM
e62ee000-e63e1fff : Reserved
e63e2000-e87cafff : System RAM
e87cb000-e87cbfff : Reserved
e87cc000-e9e1ffff : System RAM
e9e20000-eb33efff : Reserved
  eb31e000-eb321fff : MSFT0101:00
  eb322000-eb325fff : MSFT0101:00
eb33f000-eb39efff : ACPI Tables
eb39f000-eb556fff : ACPI Non-volatile Storage
eb557000-ed1fefff : Reserved
ed1ff000-edffffff : System RAM
ee000000-efffffff : Reserved
f0000000-fcffffff : PCI Bus 0000:00
  f0000000-f7ffffff : PCI ECAM 0000 [bus 00-7f]
    f0000000-f7ffffff : pnp 00:00
  fc500000-fc9fffff : PCI Bus 0000:08
    fc500000-fc5fffff : 0000:08:00.7
      fc500000-fc5fffff : pcie_mp2_amd
    fc600000-fc6fffff : 0000:08:00.4
      fc600000-fc6fffff : xhci-hcd
    fc700000-fc7fffff : 0000:08:00.3
      fc700000-fc7fffff : xhci-hcd
    fc800000-fc8fffff : 0000:08:00.2
      fc800000-fc8fffff : ccp
    fc900000-fc97ffff : 0000:08:00.0
    fc980000-fc9bffff : 0000:08:00.5
      fc980000-fc9bffff : AMD ACP3x audio
        fc980000-fc990200 : acp_pdm_iomem
    fc9c0000-fc9c7fff : 0000:08:00.6
      fc9c0000-fc9c7fff : ICH HD audio
    fc9c8000-fc9cbfff : 0000:08:00.1
      fc9c8000-fc9cbfff : ICH HD audio
    fc9cc000-fc9cdfff : 0000:08:00.7
    fc9ce000-fc9cffff : 0000:08:00.2
      fc9ce000-fc9cffff : ccp
  fca00000-fccfffff : PCI Bus 0000:01
    fca00000-fcbfffff : PCI Bus 0000:02
      fca00000-fcbfffff : PCI Bus 0000:03
        fca00000-fcafffff : 0000:03:00.0
        fcb00000-fcb1ffff : 0000:03:00.0
        fcb20000-fcb23fff : 0000:03:00.1
          fcb20000-fcb23fff : ICH HD audio
    fcc00000-fcc03fff : 0000:01:00.0
  fcd00000-fcdfffff : PCI Bus 0000:07
    fcd00000-fcd03fff : 0000:07:00.0
      fcd00000-fcd03fff : nvme
  fce00000-fcefffff : PCI Bus 0000:06
    fce00000-fce03fff : 0000:06:00.0
      fce00000-fce03fff : nvme
  fcf00000-fcffffff : PCI Bus 0000:05
    fcf00000-fcf03fff : 0000:05:00.0
    fcf04000-fcf04fff : 0000:05:00.0
      fcf04000-fcf04fff : r8169
fd300000-fd37ffff : amd_iommu
fec00000-fec003ff : IOAPIC 0
fec01000-fec013ff : IOAPIC 1
fec10000-fec10fff : Reserved
  fec10000-fec10fff : pnp 00:04
fed00000-fed00fff : Reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed40000-fed44fff : Reserved
fed80000-fed8ffff : Reserved
  fed81200-fed812ff : AMDI0030:00
  fed81500-fed818ff : AMDI0030:00
    fed81500-fed818ff : AMDI0030:00 AMDI0030:00
fedc0000-fedc0fff : pnp 00:04
fedc4000-fedc9fff : Reserved
  fedc5000-fedc5fff : AMDI0010:03
    fedc5000-fedc5fff : AMDI0010:03 AMDI0010:03
fedcc000-fedcefff : Reserved
fedd5000-fedd5fff : Reserved
fee00000-fee00fff : pnp 00:04
ff000000-ffffffff : pnp 00:04
100000000-fee2fffff : System RAM
  825600000-8261fa1b1 : Kernel code
  826200000-82663dfff : Kernel rodata
  826800000-82692ef3f : Kernel data
  826eaf000-826ffffff : Kernel bss
fee300000-100fffffff : Reserved
1010000000-ffffffffff : PCI Bus 0000:00
  fc00000000-fe0fffffff : PCI Bus 0000:01
    fc00000000-fe0fffffff : PCI Bus 0000:02
      fc00000000-fe0fffffff : PCI Bus 0000:03
        fc00000000-fdffffffff : 0000:03:00.0 This is the usual BAR reporte=
d by dmesg (and lspci -vv)
        fe00000000-fe0fffffff : 0000:03:00.0
  fe20000000-fe301fffff : PCI Bus 0000:08
    fe20000000-fe2fffffff : 0000:08:00.0
    fe30000000-fe301fffff : 0000:08:00.0
  fe30300000-fe304fffff : PCI Bus 0000:04
    fe30300000-fe303fffff : 0000:04:00.0
      fe30300000-fe303fffff : 0000:04:00.0
    fe30400000-fe30403fff : 0000:04:00.0
    fe30404000-fe30404fff : 0000:04:00.0
afe00000000-affffffffff : 0000:03:00.0 This is the memory which shifts wit=
h nokaslr

Bert Karwatzki

