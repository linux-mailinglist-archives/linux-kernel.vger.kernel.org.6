Return-Path: <linux-kernel+bounces-330525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989E0979FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0311F22141
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E5153BF6;
	Mon, 16 Sep 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="s2W1mORA"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7731494BB;
	Mon, 16 Sep 2024 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483798; cv=none; b=KHoGzVOOUZqhUBpOHGbAiC6LeTL9aKUXrRJqZL1R75ySgmA63LkUvaSCIVDAfg5uEQqyLU/ahbj3rMo3tX9ytqsB6g88HoRTKiCtKPi+bjb4QUR0bwc8J0fnt6fXe2uDilbSO2kJJzTW9Jr5uJp5Vx8GbDG6GE6LynoEzreYIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483798; c=relaxed/simple;
	bh=SprNo69rdVdRczSHmsJdPUw60b99yXY36JLopcB/Bq0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W5HaQHInZ8sSFitf8z1DxIc02Th368eZXc4HAdUcrKxIzmRbidpg/KbercSsDB2cZ7n24izipdDvWE1V42boT2pwAK1O8qdSXxONggefpB8HHFh8KXPnUAjZP/ulzyo1SKumU4vCeJBO4xH911upaq7fEZcDWbZq2ke6v1SKIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=s2W1mORA; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1726483775; x=1727088575; i=christian@heusel.eu;
	bh=5hzAWYY/NEknJFwWKGv/E8u8GFLlfQeAYhbo9E7ZVyg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s2W1mORAYIsMpGpyPrze4wdA2mqmHCwJWijIfcuAQXpAcTai8+EcSsOfvfNEiy68
	 EBkrFUBD9l3UamuiOvV1IvHJeZLVWKv54LZ3t575d83qmR/SEpTpy6mUHwBSCEQOD
	 Uh8Fv3MbbCZ8Wn6a0svaLSkkdQdRqQRMOrbddp0hKHvscd64d8rqCAUckkLHSRjAm
	 VOjfgEQU0Hgchs21+P4BP+jCt9bBhC6E+hNy1kU2f3VVAR/R1aCjVyLdvJDYfprQ6
	 htUsa/fmrNbh/wOIpqGzZbEMcXvBYxlBc8cAfw29DThndzvBR3Nt29Gl2GjTEZYNT
	 GuL45aNhYt7OE15MYQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Msqpq-1rxLok2fwe-00xpRZ; Mon, 16
 Sep 2024 12:49:35 +0200
Date: Mon, 16 Sep 2024 12:49:33 +0200
From: Christian Heusel <christian@heusel.eu>
To: linux-firmware@kernel.org, Kalle Valo <kvalo@qca.qualcomm.com>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [REGRESSION] Update of linux-firmware breaks wifi on Thinkpad T14
Message-ID: <44ae68d2-24b6-49d2-a4f9-ae9cbf6f9950@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtwz73t4edjtsbyg"
Content-Disposition: inline
X-Provags-ID: V03:K1:QsWglT6DP2QQ6QNSnZTOoWt5LXUFxyBEcnz36034CXpymEqk5Fr
 Y/ksxIb7uuIgqg/81rErmJgB2g74gxP9ihktXYXku4V3Xvm4bGlFQ8/FL0HQsHTzOqk5qWy
 HActdzqPpAv86Q30Dgr3yPNEoo5H5tFiQl4JS3SSt3AETJqewX+uxnLIJiPVGe0VuW6wZU1
 physKz9GvuEc4cnsAuiIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gkH3q8Bu69c=;2jv/yQBSGIGFJozcIV6797HCfDW
 qzJm4vcMpm4Qaw7C+9aWJa8rEEZqA5xyAX6ALyXqK3gMMftrz/8npsj/bc1iW8hu0OvA/7sSD
 JxBslIEJiVSp755thVNTGrn17ZjZ72vLtR9O/owuSvkEzIVeAfzWTSFex24okOdTRTWPIGrN+
 h2A1nET4wh+syZZ2hyh8HNygyVydzNfY+HtVQJEBnBWbL89vDO9zV8NLbTr9x5HB6fT/cE00O
 1ZmPnArK+3uHaorxKRWpAvOC0LhLI+84HhTU/UbKP4UbjS83OGwpIwNnNDxDfoc5dXLh39KHe
 sHOPQsyxF/G4vduggrADk0+wsXk6KC1x9cPzXrNtdzxFuHSuAqSwaLM66bq0jx0rtBWF7mTXd
 ZbUrLgZ4q2dDA+EC4aLMfj+DMNnpHOw7KaSsv4q7Xv2HKH7fHle6mEaE4c6QrAA7s0u9szp6q
 tSucKP/NZeEHTXiPNw/gWgT9v60ABfXHFPMms7Hunc0ewxttzB5jOSR+FZ1XzVOSQ2oBFN9+b
 tR4CjR3dHmbMT5MZacui1kbys5+xooBVx1QkX9gLyJc60MH1Ve3eHe7AyuYwhw9TkoFjbbIxN
 AqLS1Twl3nzMeqZkbn01fknOB4Px+IaF/3yAWFtaCvF0YGJwFyRjriHLT3W3Ndx+0kKdkxjER
 FKtLrirsh+1zG/Gy/zuu1uTZ/pFxu+Nm5IKavpnFo0up+VzR8acFh004eaNTyyQpvgxU1CzGy
 VKQ1Qvj3PezOM9aTryIEseKjhMsmgykOg==


--qtwz73t4edjtsbyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kalle,

the commit 82318c96 ("ath12k: WCN7850 hw2.0: update board-2.bin") in the
linux firmware repository apparently breaks card recognition in Thinkpad
T14 laptops with the following journal entries:

    Sep 10 12:34:01 gdb-arch-t14-5 kernel: ath12k_pci 0000:02:00.0: failed to fetch board data for bus=pci,vendor=17cb,device=1107,subsystem-vendor=17aa,subsystem>
    Sep 10 12:34:01 gdb-arch-t14-5 kernel: ath12k_pci 0000:02:00.0: failed to fetch board.bin from WCN7850/hw2.0
    Sep 10 12:34:01 gdb-arch-t14-5 kernel: ath12k_pci 0000:02:00.0: qmi failed to load bdf:
    Sep 10 12:34:01 gdb-arch-t14-5 kernel: ath12k_pci 0000:02:00.0: qmi failed to load board data file:-2

Is there any more information you would need to debug this issue or does
the above already tell you enough?

This issue was discovered by Arch Linux Forum user "Mezzy12" with
debugging help from user "loqs" and me.

Regards,
Chris

[0]: https://bbs.archlinux.org/viewtopic.php?id=299286

--qtwz73t4edjtsbyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmboDT0ACgkQwEfU8yi1
JYXn7hAAy4QCSRzmKXEmAbMIKZaG0C3VjzePWedQqNpzFw66FWxIsjSGrqs+p2Qy
/jYWJ7OL0UgHAXtHwFEaAv4oidWrSXTwgNTI216Valdm3vijffyFyPOp0lbJ6Iuq
GH4mW7ogHAZgUqyhvoK9HmZugaufCVi/BACBF8hz4cTbKY5i7HAa5CNkJ0jfWheX
PbvMNS6lEA6xdVfyv0ot7TZYeudfIGZcaDcyyGQeGm655iyHhJTjnhhr+iOUvi0P
3IStoZ52p0t4xw/Li0scBIhenrHIguDLzqHiwOpSeZUG4a1zvPlm0GPMO//lfWvF
j/XNTDCjUhsyiD3geVX4k0V3rhbiQS5LCHL0OSLD6Um+yyv4jFKY6sv5dzxorCDq
nul3digeUItTbvSopt8CuN+Pu0S01I7Hdhczw/p5cWCHxj2Pjwf5SduPOZgpKYjl
qPL2q0EogLYEh61Txi6V7qrHL3krofEmbBpXFBmpA80iuw4OJ6N3+Vn0xBpmCL6n
S/6aplzFV2in4USIYmqIy82eT2me0aDR3P7W4lj7P20HKqE5vIsXE6eifSL04x0z
hHfBYYnuKld56D7xXSnFhyFDqWTihznU+ektVIHpHtxpObyt8ikZQkU9gLgWyNb9
9rQ9KZDpLmrcUVChgho4VLxjE5XjqhcVQRF2tAM9724kQW91a2s=
=ekkO
-----END PGP SIGNATURE-----

--qtwz73t4edjtsbyg--

