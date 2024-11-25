Return-Path: <linux-kernel+bounces-421646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0499D8DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD463B2A3D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002EE1CB31D;
	Mon, 25 Nov 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="CAbl0xFT"
Received: from sonic309-20.consmr.mail.sg3.yahoo.com (sonic309-20.consmr.mail.sg3.yahoo.com [106.10.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7818E359
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569715; cv=none; b=bKLwi9LSqFPCTgFGqOMX+COPDIeuM7I+9YV5FE7MySXAE1Kbn9aitdPkuJS4VRUYWyIbGWISP+QXIGbjJtf1L8SPI7+fHSC8gB8/bf7SLuxOlaow+iQJf/Rh1XSZaKkD8icNUBCp3O7j4ddtPdyVbWGwk1Ik1xQsuuiZc5Gg0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569715; c=relaxed/simple;
	bh=6eK4x3vju9hJJoNlFK1G120YazU8r8EO8J7R7KGanhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go4mPPStxvfmV8CRgfQIZkE3WnSfs8DviYIIae1V2H/oz675Z+tgZxE4SSQUtKOUzf7fsXjjKiQjBVLUjq+l323/0XMuT1zvC9IP55GNA/XbXhdQ5wKXI84iurYdMnEyH9xNMU3SsR9LJ74SpE+lrcsjjxWx9E8RSU3VwyVlUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=CAbl0xFT; arc=none smtp.client-ip=106.10.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1732569711; bh=6eK4x3vju9hJJoNlFK1G120YazU8r8EO8J7R7KGanhc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CAbl0xFTpjXg2CbwPTOmkSvXTtGwTkS6tpXY6p/GJs6r64YLqiFbAgA+4X/Qm4EL/mbkAhNptVYg1SE8xffqy/Q1Whed6fj7iiITZNahk8qi/57SdcGgA84R26JUwh5c+mcOgqlY56kpV6zbm2fX29Qzw7PbIgrcd0tx7SrkLSbWIqm3tVlGsrXDjkab5UXm7qVtfpEnZ5vLmT6wWuDnhMGTS8/Ll6Na5XijRHmm44N/B7wqxEVLG2IIPF5/ssSXcFBYQTRDnu8YS2AzX2Eiou8BAH5piO8Rr2itjZAq2br4Fc1AvBt4bb10Birk2Kgf30PyGTBhcIMDdorlvTGdcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732569711; bh=CHAW3SsHkjxRhfIe5PhULy5Exs9SLeW8N7SMHgDY0l5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GBaT+TtI+YlavD1kkXwWAkX2T1u5ze7gnR6ApVtm/1Fz8Wi0/B7K1bKz19Ik63Mgu7eTn4TGU2ak/thEYKMHB6D2/o3Ir1j2MwRdHJ9Nrb40wmlIhxAIRKGWkG1IvJgIfcw82B3B2WzNptLfmWn8iBexT5Kk0JF93JNRJprS5ciFWFPSKPfpnCypO/bA/KwUi2lgiy/EFURjfW/EzOgqP9TxpjSB4cR0l+6wK0LgSIaxeG6VnpbH885AtR9aMM7zJuYJpD023V9C6vDQPzzYHRB4t6fEOqv6UrDTtK/pdQu8nPawGxX16AuJllD1gt+cIpWctPvUvAkDWxNcL+4gQw==
X-YMail-OSG: Al35TvIVM1k5e5Ms4ei9etFYA7AqFv1PFmaL3SXAjJX4fJhrTeOXgku6gkRfVNu
 gCPO1674IxS0Z.UflJoPw6Pt2MOpsoSI9Wv.MRDBFUldWS3VlTM8_81JKvOaDNzpqdPumsAMx58V
 zXupgRkAPLVQW7P52pdoayWD5HAgRHz4aVoHHlq77Rs79nP5ed44ZldJ97yM7CBalHPzHYCaxAEk
 tSX91BI_CdiE2RTDX52XsZcBsoHPrr7l1jhqkEEBGJTsLBG0Sr0ZplLYIa.i275MUD2fEYU6d7kg
 vv.q.8uD8b6Z8PiCMrkInEBXOPzsQHAEzm58E6RiFdlj4HdcjDvgPK7sz5e7_qzW.9qLuYvh.Uxe
 RBoMiN76hXn.JFI51aIVHumlGf7kY3nqxJAUfbgZoQ6b4Z.xdfxCaelB_kWUQwhIc4rtYKc0ZzuB
 ErwADkA00E23GPPuv6R5mDbDYc43857BrJwFZ7PvWLa8l0yZXriYBdJr8xRStOrCOP.B1A8epUx6
 AurOrU63j7DPAawdv5YX_SH1KUJxZyY7n0Deb65LzLzfstPvMgj6CMtdR8RjT8bFhJA.HNHNrJ0N
 v151lIa6eRWG1dvtf.mGMI_iNQHjb_Mu.rkB5.sdFbSGjBVTcA2z770wa58SJE8OZum8HM6ZP6Fi
 COV3pnF6suHbeaEE9GdSdvX7i8m1ky9yy504IwUQA50ME_Ptnfem3p8KkX9lMI82xmLWX7zILumn
 rhnxiHDoAAEGwAqTFn7n90nu2Fn8_CXKOVUYjTi4JO2.Z86ID6_3XcglsSdoTyRDlXYrVyGi6eHW
 Z1g_vm_cOzO87BNgVk.Nby87LI5Rz0boz_p6GKAFMFyBTKESkf5q0YXKx9BNUqp7.yN0DwAzFkZ2
 C3vH.MBIteKgFfsDp.5_rDkHOIKeZN_ZWXbPl0UZH188CjReE9r7tXnDtjXS_rkM0KVZ5kkRmAIk
 RnbI6DniKnVqh6lGGSAtiKEgXroU56fwT9Jpz7sGjd3Ka0QbeW88rgfJITNWcQ0PIEZ5toyNMpUx
 2mrBoKiPfmWHpwn4W9vG8l2sFEoIAgdZEvCmOCKydpxCVk13lwzIxBo918KY7_i20uoSLW3i6m5u
 k1.jzxOigJZP60CseoIl0eKBm18_Wz27lV4wIlaJEbKMx_ymVTXplCoDh6MmbBz86koZXJibjoyQ
 eBZwO.BSCmjJ5h.wL.Gg29mshDCLh3geM7SDxq2hUTjszeV3.Yg29rUZgGh0jQgWZrmv3Fjv3uem
 NygEuu7XsKwA_Mlj.Lh51BXFoxFFiDa7Wt1fUXZo_pRT.n_LSHVuluibfG9GXYMGX1Qdu4jGLTDG
 GjYjQBEpfdatAHf.f5jLTOebKC8Fv21c8xHrQInJisvL8lERpNXwhYfVcjQDs55WNGZZYa6WP1hI
 k9rLTORmyZcO.K6Xd2FWN.G89ar4kwD0CfgK3oBZklZ4WZL0Q62we2sjwhuJJO_wBqB4NjZcC9fv
 VN1M4aJYh3ElWr2CuUGySCS9rgBYf12bQjIgrrnq6jIqcZH3vgdJ1KBNqThOwIZZHVTWdvxXHQGA
 8kMjP.mhh12t6M7kbOwoheN7gsvtUpS75n.imQepKNX2Eq.f0f.JVcZE6cOdw91ktMyodCqKzUtX
 US1qAAx3yHlR85rMwQPWIJLi553GDqoHkSbF0JmxbOZ4G_XfZIeaT0DuGKaBYSsnrTxF0P1QXB5M
 TmvW7LK0doC2PGrJn1a72NJGExH8SiQtC1MdWED8mPavRrhT_AJNi9wx6ui0r_VCulpXMO3VrLIS
 X6J65z.VHl4fxL.B6X.kBppNCV6YSuMq0yU9Id5ZuUpDM2N4WLurwlMAyS3UM.CCgoko4D9QuWmX
 Et4W0keJxHYr_LE16MmJFTuW3FbaTJENzhZJ.YlnB1VjZGsXZMHjyCKpFkv1r.TzorrW.bpRlri.
 i0D_piR5YGm0xDOIA7LRlPkpl69_o6uKPY9d62EZpR_4twWtblj9nYPuFoPLU2avBedHyflBWbiA
 PKD2cHSZ7J77hNYN3R7s2FfefD_cDh4QsNDl8Dbkl2i5Z3QtLPAUmgYYwpBnfP.mJE5PwMsZTqj6
 npA.TIDZ3OKWy87eiz.lYXen.BCF9tmmdDNufh6VLW2LXKQMkYWXzt0I6u9dWEjV_zWHy55ZL51I
 PwMAwG06Ew6TGNDYBcEllQJQD3cFTTpY.CgdrWCFzEdd8r_eG3n_XYWoWiKTryvxnFmxTYPz4.NN
 LwrO2P7V0Z2sfvHG_ZXGe9e6Spzv8EykCz0aCOD_.asLo3e8-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 9a50838d-9b58-4b47-a13c-ffae9836dba2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.sg3.yahoo.com with HTTP; Mon, 25 Nov 2024 21:21:51 +0000
Received: by hermes--production-sg3-5b7954b588-5j5q2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f6bd66b03b94779d3249653df70752b5;
          Mon, 25 Nov 2024 20:41:13 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: krzk@kernel.org
Cc: abdul.rahim@myyahoo.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] nfc: s3fwrn5: Prefer strscpy() over strcpy()
Date: Tue, 26 Nov 2024 02:11:11 +0530
Message-ID: <20241125204111.39844-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8e68e02a-2c58-485c-a13e-a4b52616e63e@kernel.org>
References: <8e68e02a-2c58-485c-a13e-a4b52616e63e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do i need to resend it. What additional information do I need to
provide?

