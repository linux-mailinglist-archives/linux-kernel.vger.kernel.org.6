Return-Path: <linux-kernel+bounces-425232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D899DBF1B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFDC164AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE4A155725;
	Fri, 29 Nov 2024 04:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b="qY+3Gzxc"
Received: from sonic305-1.consmr.mail.bf2.yahoo.com (sonic305-1.consmr.mail.bf2.yahoo.com [74.6.133.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685D14B06A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732855585; cv=none; b=soN5RXbKMfUMLerlLzSIgWAfXdAs3/K6YxMMYHtzf1Mrn9CwxRVsRUZunVcVFGkMiBTsx9eNy5DouZVBUrQxEjtVw5RhhUAlR0RXREtgi4gThVkALeEB2FpeNZ8DfWCWMpM1xC4MVPXLh/VMd/vjo3024znOHMAy13PXPMOnT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732855585; c=relaxed/simple;
	bh=+/KmO3a3ZqPkpk88xYk2TASZx3w+zAIDLk4JhcnfO3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=rUPhuhk3rh7O9JI4dmSeRJzjfIajba1UFwlTYtJM55+LQJG7NydXYchNF2jG3b1x1k6S7KbK4lLRO64w40YtnsaEjQ5VQi7+rS+e00WmYptJQMqcZFlPwx8pZOUwWaVrQW/KyRHNLaEE7uLDyDXJHh5Oxv90giAgVScMJpqlAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net; spf=pass smtp.mailfrom=verizon.net; dkim=pass (2048-bit key) header.d=verizon.net header.i=@verizon.net header.b=qY+3Gzxc; arc=none smtp.client-ip=74.6.133.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=verizon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verizon.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verizon.net; s=a2048; t=1732855582; bh=GQSojATNMkj2XY8rz6LmsRqO9TSCVXvI4iHLwdFwzks=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=qY+3GzxcUPPcwbZkGTOwpwRu2KQisAkhKiucP8LwchPDpjBCp7wrPLbkppgZasPXMvUXkOqsKGq01leQE1IRP9lQpqgCgMKteFDgZeySOnFfFoyQ9xU6SSHsofIgCvWL56PA1wMZlFCVGbRliytpiXTOSYGxb6gPwXHdEQyjN6FpqzVRBmsEG3aqFyHEgT+CgswQooWjX66GecWxpJZdlA0oPiP/v/Y6uZX8IV93H3oy1FiLsuI8Btr5AB9rmrL+sXNtvSlargrkevG0zqjOQ48OSPJ5ezf8DDc3mYfkJx+a0r25feGBBQbjsxu3i73laNRf/mtFEu4vy/RUjA8BDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732855582; bh=pKGlfdvHbyXxDgNmfBshnq6bZxxYqbKDFghHL5efTb9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=e7nzM4/iOveBUzaElLvvCsI2pXUWoEJzFvLPiMgVLdmb+jBmbGe6GeXaHNAKVF6Gi9kPdWBbm6os7xLsJNc1vAEo01jDtnOOrA5eicMQxKExYvhK23EWfNomgEa8cOjyloV0oisR+IyhXRhJk4mW4WdM+taN80sHi7+1en0ltsCanpwTHILKkGgDLtZkTX6QII5i8yRYkkrUhCgXiBg+Xom+01miNGQUsctHD9YbvRYH9vw/+fSNOi9PxBQ+0j4ARBSbocODvjoba5OD/nRSO4JBZiN/eZnsZxAnR1XABvnXTHuXiDoGDZnhvZq7pBYjHAMjPXr/6EmtZvfTU7siPw==
X-YMail-OSG: AMSU.RMVM1mb6bKRvoYirGQKxOZVMJWCgdDqu5v7FdoEhWK8eIccml0v4EFSHY1
 JU5RphcaVbkv10w0R5D_JTx67NbJFP1zgo1dZfssY34mnvwAY3xHGuPTTNoQ9xJC98XZp3N9Kf.e
 3hPJoJvewqy69HIMKGVFyVWcPmSjEyiPJRTKpmLjuMUJQP9tqfm2Z7QW18.ejM1ToJqldGwXSFf7
 9bfi3pVlBFKf_K.xAxM2TsWjc.UkFA6ozUeruAl4WaTcMaDoBq5ps3sb8LHHFYqxX1vDzZ3hUFrp
 0GuXSmPzrb6dRsRtpi29VrZGIaGt1_3ISPuPSgnxz_3hZACJSkwOagx0VntM4IECaqSeRSIOBqlo
 ax.9y6YA3.qX3q7hGF7_KHji4nI6Om6Ae4TCaoshiOdfsdAlqlaigNl9HchkdZFkHA7eIFiDKLQI
 jjSzlQmOJ6ptipPS4zWcM76JHAaP5FLJMZoCrcZcs9zedbhhT8mjtkoef0hrxZ2_6Ik83XePo7FC
 vZMIrVGtaeHFyOR7iIgOpS_li_riOTfsQlDpqFFlfUolP6EvYqM485dEXFX3oqegD8jG7ogNWQEt
 OfxR2kHYIDGgtzF4.12AEgjlQNkXr9TgvHwc3RXK3nRcCKzYypscGesYW.KgoeV74qxS_BPiQ_DH
 2F3Wa2UhHaKMAWIC9SxFfO2zXKTH7pDkaaf57wPzzWYb.T6qFpErafTrAWJ4cVPtEJbr4qczudDW
 YevbO2pxFdbP479PElYGWPeAGOR5tR6iFYdKsltyA4d9qQPsR1fLci0cU7PsNyeIIAR1N_.HdHhQ
 mZ7SXkqjZ7diL5T.pns1.cegBjDWOGJRcLcr8qyyNW7xFCLAvIn_2PAOyIKu.g6aEqRYP9G1v19p
 uSytSUubfFr.fWw1wt0i0_HXR250QIVCC.AVBYD4nup20m4Jdu6WIrkPcfWkDD5_iBG7x5RlIWml
 ceYzM6NBIwGoTi3xFHuL4on1adsmfifarkhOFZZz2wMfvk3YJ.MnynMMpHKfBMrZ5j8VqCHb13vr
 NG7qZCuGnxytJrP837fsfaMBtvVSSIZ3IL1wqtgTtxA2G8i_sCZ2y8Ur4UfLnU_OWHj.fHKAVmRs
 BWpIhPr0dvuXYYU5lqvywS.MfAi2FlaeTgOdlMKiGOCqZScGc7UdzA2gkd0dS7edzD22_tZ4qTFw
 w6DOSJsZZEhjOtNRuOuth9dr3RyM2jiIjBXyjpJ.OQF38mjQTGgsMoreJSQr4ZvRdueQI9qQmd9p
 XsqNPX1qxA5t1HDZbLGyPnlY3GK1M0O2kVXnBF4j4AZ8Gx3H6jxRf2OA01jl7wujvo2RraPvTina
 by_qwjx6lswZiv2YWhuHGz5BBny_0GO7..FOHaD25QjYKZsWyTTyYEYCDXfcozo_QO06DLHcxsQG
 Om9ovVPBlRVuYRpj9s5HKVGA2JMwgcGMJfXUmcvaMPEr32tCo06v8occKdJdn4wOEnPhqyjoYoL2
 ODoHtfITzvkkrIMtO000OpcD.jRm.pYp1yrfdwuvUDyf3vAP_fKgaNeRYp09oTu6nAZvIyrRYraY
 ktkPKVfItlPhAgnMz7j6_q6HSKKdBXf85eWknX7rvk8wuXGiTLIaNPr86yemciv5ud50yfK8nsF2
 SwPFb4d38wTOIvd9UPgLaQ0Nsn_6lo04khs9O7DzmIe2G0Cft3M4lqob6JNiw2jNeiFgPehLQIX4
 uySRzYDwO4wgkfYtxx5CWWFhmWwoeEaT0_1SQRbe.ru8erdwbkpa5ui5UeUeTtRQmbrArEXpQVPI
 lLaN1Mn.xIakdySoWc8MyouSnoGOc0Nj578WY93CTPQtXFTL.gi7ttX9OQRmFdkITdRRXXev25Eg
 viWaZWmCWq49JanPLS7FXm5TaP5WAuF1H1bhrYP3buNUS5J48rI8B0i22R3mhgM.16JLzTQwtX1p
 kd9MV_xf6mhmKPp0InuFPZHDNhKaUq7qgSTm88HJ1W89W51OgF58aINB6EwPf33Hiwaqz_EXQI0o
 BJWORXxAlcA4aoyBdoqqEwRMaN.Suk6ZBmVPojXEO4gQlOluGfWApxlOaPIKp7Di5E1Ee1IJXixr
 ThkEFHCiKihwaxHCNfTKF8.u_6hpBc_iC9Yh1rCDxhIA.Gcz.27VfiVyS5_71NB.RVJCAIMfxsXe
 _KT83YdXKEBPJ9Xl.yMFzjjpMPN5gaoZHcpNu43KnOjfASTGuRQHmALJU_TfeL0ezmLCqrtNZoOo
 qSmaNopED3kkD4BbubDcJ4EJ0EbKnNnDrnhU74be8z9Lbq_JplX9JnqEpLbpVQxCPBViZnhlb3L1
 WU_dbo9zh8IMi
X-Sonic-MF: <bluescreen_avenger@verizon.net>
X-Sonic-ID: b678fd99-ae38-49d4-b635-e51f217fb12e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 29 Nov 2024 04:46:22 +0000
Received: by hermes--production-bf1-66bb576cbb-h2pjb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af1c0b40292d512b9d850181f2953147;
          Fri, 29 Nov 2024 04:15:58 +0000 (UTC)
From: n3rdopolis <bluescreen_avenger@verizon.net>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: n3rdopolis <bluescreen_avenger@verizon.net>
Subject: [PATCH 0/2] Optionally allow ttynull to be selected as a default console
Date: Thu, 28 Nov 2024 23:15:47 -0500
Message-ID: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241129041549.778959-1-bluescreen_avenger.ref@verizon.net>

When switching to a CONFIG_VT=n world, at least on x86 systems,
/dev/console becomes /dev/ttyS0. This can cause some undesired effects.
/dev/console's behavior is now tied to the physical /dev/ttyS0, which when
disconnected can cause isatty() to fail when /dev/ttyS0 is disconnected,
and users who upgrade to a theoretical vt-less kernel from their
distribution who have a device such as a science instrument connected to
their /dev/ttyS0 port will suddenly see it receive kernel log messages.

When the new CONFIG_NULL_TTY_CONSOLE option is turned on, this will allow
the ttynull device to be leveraged as the default console. Distributions
that had CONFIG_VT turned on before will be able to leverage this option
to where /dev/console is still backed by a psuedo device, avoiding these
issues, without needing to enable the entire VT subsystem.

n3rdopolis (2):
  ttynull: Add an option to allow ttynull to be used as a console device
  tty: Change order of ttynull to be loaded sooner.

 drivers/tty/Kconfig   | 18 +++++++++++++++++-
 drivers/tty/Makefile  |  3 ++-
 drivers/tty/ttynull.c | 16 +++++++++++++++-
 3 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.45.2


