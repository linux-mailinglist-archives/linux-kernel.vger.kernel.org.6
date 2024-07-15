Return-Path: <linux-kernel+bounces-253167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F07931DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8783D1F22810
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B414386D;
	Mon, 15 Jul 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="d6e/VSi/"
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC814375D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086850; cv=none; b=FFR7UYahYVK2LY9igEDUmMxfcW2nZ8GcHkuHy+sfE9AO1TBk15zV0kGpm25qTb+PeO+LUfTM1ddzvAMjwVLMeFvejrTvcSbnHrHRna7JWSoiaavm1WvdATVrIx2weE4OJkG9vQ/bDB0dSTcMRL57+iGhMIXsrdDD+QssfAuDrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086850; c=relaxed/simple;
	bh=ZJqlczQnyFnkjnOMPY6EOJrRY+9hZErhisnAph9h7mk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=V4d8Rq1494E4tK+cNyCcoJ1prf8wyMOqzlRHpfupFyHZsvdpyoD3V/fP9pN7DWd58mu8cvkzhIyn8YsD7So4Zc4TJtXeENxazYBgslMKsW3Ggw8e4nBNC/KE7M6EtDv8IuoRKZyUYdqUYsz/+tmxd97BM1kjBR+Cw+l3vsIO4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=d6e/VSi/; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721086847; bh=m6fvGEXDejgdvUwq0XGyGydA5OkCYBpq6UuMurIHjTw=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=d6e/VSi/0e+6ajidiaCmRwYQ5xOpzB7TcUJ+tEjQmx79RMGK8VZkVjn8oVuRZZUzawlhgj3q2RAsyK0+ER94VIbRBANBGezdVEZC8gAy8nQn76YoTkkgofLk3PrXuCYdguGF6wdOi5a9yZVXIvxORf026juRiOWV8X0iSiR6Pd5eNXI+4f0UWj9nWTHDV8q/ZYiRlb4bF0/DSlMduJ1L1tYMm5BvpX5vJOuTfdv9+Fl6uaZRZEtaLVcFWU+5VmY5mFl7LmS06YRGvNxbsbD8ngiF7d3KM1VEdLn6TZPrTT7lXhINrlrsTdn+CP0vWKiBMUK1H/ncmRvkUPZZ8eqMOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721086847; bh=5euts7Cf5NmJvrh2a2pEQdZVUAVuxcuwCyJ7ZW0vWJI=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=ow2d6h4R8P7T16UCagQ2+BN4THofTcJbW2WSUChWRBCsfBFStKvs8rtBsPZpTp7EXKrt2JBOBr/pv1ZzvMEOrAY8e8ucuqGRTdrxs6ioxdzs5vzSNQ/6nhuEsdOT88leF+LHULwequwGs93iwZVCHyYmhnRzDLO+4Mx3qBSnBry9lExM9tYYBMLvwOyjVSWGgPcRYde7Nz93UAfKeNI4pE1i38oaBRZBGXwszRsBWLTBxfldSUo7BoYa+f0bgIwxw1SteLCiKapfNg07GOBa2HIegGFVutDo3amKn2kznE6ruE2AdGbjmddl/WHmMZfV4mtY9pwZcn5T6NH3DBSoiA==
X-YMail-OSG: mxyPJDYVM1nJVmTbGtE3C_daPg8SlpQky2xlF_dHlMBN734UkW3BhN0EO04dETu
 LcuIdQeyNBq71.RcFvQ7XHwrozkQJfqxgEhrznvn4tf2gaofaE269dSoqWHWov3pA0GINaRAQGYb
 22aN0BY8j.9u_Wa06v8I_KA0FMvMv94Ta1RBOQ5JF1qLI3R3u5X1hA8z9Oyimzbkv99rDGTFdbaZ
 Xo1AQCu9BvD5OF7LkTEVCNQBng_5vNMm_nmuxPB3MPP6rr5cyOfsZHDfgHyNvJc_vJ2k5ix1.gr4
 .uJvPSzpTPCh5cjwrKVgcaqn_m.VzZVDhXrJpEettds6lZ4KQukHcP7qM1ihwGOdSVfGmUFutFYC
 c8etb5uxRDwUgmPn4u4gh9W3rry4Fqw.4nGFVliFtLy82Uyt.B9dIfSiUDzu7YEBzqyEsCz3YuEp
 t9hB.UaXhOMvtGsURb0X5Q4CQ872waWFNiP5fRcsXAhNhdgsq01a6vr1l6feD8iemfvR04l4b6vZ
 qnuW4wrjSobrNZFhry5bsd9ileg040dJmcS_oYwRGCTY69oGGJw6Wh9gPMwOwfqtYWF4P1YqmNT.
 FY4Mvbj23Nf0g.9xspplPYUB0YGn08bzQaMqyHaRQS.owM4K0mTJj0q1sUdFe4RCwq1Nwc2TwoZN
 CGKiCdfWCHVWO9EriXrk1fgGLf9sPyLKJaea8MyCcR_uyS_64VdrzYBcxNG3zumQXz_oyhl66m9C
 VbOz4TulrHGfVdS9p3qA__y.wvFiZuNzjeSPWJhtpH1fMYjse5E1nJE16NhnDBJ7Pz0ZQmxgV2GY
 tk9TY.K3UtBagOnU4owwp8Cvw7TuwD1GPlywBjK1iItml9FMYLCfTiJbe0ZuI04tntDuf2ovtsKc
 SZEbu5sxEZPRzL9nR3dcVkWFLrtdXWylSnV5fRdVN14cb7D4wdEl7zTY90alUKLS0rSfTbEUXmG0
 8uynlFYqavs5xJBIMrO4Z6_jF.kfjF3JjBYHY98zovDFdWpBU.bTqUbIqT1qi9RpiSXv.k2UdmJy
 XBjyyOc8xOmKf9q7axqdwFyn.9BSpbtRGjpsu99M4oVVypHbGrkG74VmrW61CPWu06E.krdsDz1h
 rXcm3Eyz3vFIcycrYqVzO7R1q4BKIKvq_co6RBTJgZ71iXfEeD.Orpgl7D9rX0yVgi3YLRgQP.Wr
 NlxHlGTfUgFlH6AkHycesSduqBSAVbErXLR1QuMCbl.zk7S8Ijr8RnMhmaUTnzooEJcXmEtBBo2r
 kltZmXl1kq2O46zCY9uzhf6Z_vKTg0f5sm7EYkrBaYZLfpUskvXB1FH6HdPpDerfSHpQEisdd_6D
 GQYw.dGyVoW82cIszRhCegLF1PAM5rvbSq8ZAEQMVpvtvJpd.XEKDEg5fMBYQWMq4ODGWC4ZReTK
 U5E2_ZUKgtMRE75oM8..x_ZiZqr5CJ7CfSH2_rTc5dcpaYr69xKjcIyebuw0WZytN7hjr1IdDFst
 P1bDjZRwJDPbpQXjKip3Zpe3QWu2bDlkLkdf_gOJxngftr3q9vicftogggT9Xa5iGFYsf_isdL_z
 VDi49f7g7ZLP_vrN_bJ6zsPJ0fZ.2P7B_iyUoQzJUf9axZ3QgvQw_TDnAHIhy7RhefNRNAqTOQT6
 hu0FUbMUzzk69UXy45RARzGu86.ygmD.JCn7StygoSgi9udRTCbzsBRCJxD6FWAmEYnKHPFy0YOD
 EP6R9Q5fPgfroNh_u5hR2WV1HiVOrvh0ngM7kc5vXr6s8DbK1h_NLHE5ftC8KgMPkFJQBkEpRN.N
 OMFb1pi8OmMIeMGi_GlayNMaWjEDOn0GPAr_yq3RPmWmyqY8_rnig_MlpXc._U3j42HTASde_MKR
 5wiXDCKMVWwAv5QitoQ05T2Xmms7Ik48oJH5QT0VQGMLwWVgM4kQ6SVLMxuLV_UxbfaKk5WIQ2gV
 YJXrJwXD_u1THSXIgeaBesnAsUcmOr.AnT_yLpxAfhR_1r11qCD9yq5nLPup0z9LQaMSXST_p8ZG
 JNYjbxE5xQd2SYdW.arUP3x49TZnIrTX58TaKVIclsADDrFl_WqCIV38buLe91VKwx2z2TbHx78n
 uLl7QFzDRu_KVIlbjcxaByCbDVC53oMWbhaJcosg9v.ibuBOTjBBgp3Q9XmzH019ZZ2HzFw81wuN
 S56BkFPL9lak1PqZ12Xj4sqXQODOMnXNyTNIG2RbMTQ7zwW32rkKGvDmc_joG6KI3c4WIbL6Qc63
 i6K1hQhJB99xQQe7F9HEXLdc_gKynecsjfe5c0UmjNXgdzrQ8U4qbALi9PwufBfo1hEMcksdsSqV
 9UOw3
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cdb50ec1-fcdc-4a0e-93c3-ee133e69eda6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 15 Jul 2024 23:40:47 +0000
Received: by hermes--production-gq1-799bb7c8cf-zh7nt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d1bc5c0a4d958b9d32104fb379cfcb74;
          Mon, 15 Jul 2024 23:30:35 +0000 (UTC)
Message-ID: <c9842562-3564-4977-880f-9042ebe43e62@schaufler-ca.com>
Date: Mon, 15 Jul 2024 16:30:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Konstantin Andreev <andreev@swemel.ru>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 6.11
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <c9842562-3564-4977-880f-9042ebe43e62.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22501 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Linus,

Here is the Smack pull request for v6.11.

There are 2 patches. Both address network labeling issues.
Both have been in the next branch and pass all tests.

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.10

for you to fetch changes up to e86cac0acdb1a74f608bacefe702f2034133a047:

  smack: unix sockets: fix accept()ed socket label (2024-06-19 09:25:00 -0700)

----------------------------------------------------------------
Two fixes for Smack networking by Konstantin Andreev.

----------------------------------------------------------------
Casey Schaufler (1):
      smack: tcp: ipv4, fix incorrect labeling

Konstantin Andreev (1):
      smack: unix sockets: fix accept()ed socket label

 security/smack/smack_lsm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


