Return-Path: <linux-kernel+bounces-336052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1442097EE82
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455141C216F5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9E198857;
	Mon, 23 Sep 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="NB0PIcUb"
Received: from sonic305-20.consmr.mail.gq1.yahoo.com (sonic305-20.consmr.mail.gq1.yahoo.com [98.137.64.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805326AFF
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106610; cv=none; b=KblAOkZEim1RxdRVpEiPnuvvI2a7MVc13h0lJXZemRWt51JtpiaMzswXxsz97ejg/Eq5g8XM+c6biBUmWvIwjwezcilpMr/VAAld73UKBnZRG/5FtHKMPx84tUSxveeBi8ZPV+pwTU9U993MTfNBUkWyO/zvloZk5/Xiqe8QxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106610; c=relaxed/simple;
	bh=m7gmdD8IR1GDnTfYGVrscBmNtC8GQJ1KViOdGMI4G1I=;
	h=Date:From:Subject:To:Cc:MIME-Version:Message-Id:Content-Type:
	 References; b=tvUEGxkOsUr6bv6JNrmpux3cNnljGCAHUZGXdOEuJUyyZErmBPAbSHw/e8tr4ZX5cAsX0xWYfCgI1CtoGa7op8+IG8ZwRfxXNNaOn/F5Sfb7av3zcVLEpHcdDQL3Wg7x2U2mU++pfSNn/n1se30SqjPqCVLTDdcbsZNK0SuV4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.ca; spf=pass smtp.mailfrom=yahoo.ca; dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b=NB0PIcUb; arc=none smtp.client-ip=98.137.64.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1727106608; bh=m7gmdD8IR1GDnTfYGVrscBmNtC8GQJ1KViOdGMI4G1I=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=NB0PIcUb/6fR22UqzBZA3le2oW2iq38IJxLhtMQ5+wyVJGbqzg3L4BqY87ehEjRMc/fyr6ulzL+mE/JIqV6U5milMh2kRnRrx2t6a88S8a1Wh2bT1uod+4ClfoEesUG6ANr87U8+f9Zk8ffaQ5NEFyCsKCtsIA6oglbIojLQzA6rYst2nr0dRCDjL3lKYXaO4EaujKGibZ1xNf+y+NXdiaJWcL2C0Emef12mCocHz9mGlAWRJem6dd2BWvwBVroREc/ECuw9stCcvlDkxqV7DqXWvc0qt+2BFjKmdGk6//ctB9H1KzP5jG9fK0+wMU2LpwBHESyHuCwHkEOolGv8IA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727106608; bh=604I2lECrbEYUTyzZPcWrVm8nD0Quv2+8p5u26FG5Og=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=soaeM5ApOPYQjStmYk9ujIjtC+VtqkjgTx3CZy/ugWp6rG8eg0eUcA8xHOinGUn4p1poky9VDRqRp6V4RaRYUtP2dBNAosv+/9h7A5qjPVVdblR/ZrJ69NXLTi39ec2WmPlGETSbL4DIVxcdHgc6Yj/QdwHnTYu9gx9kuRhu05IaPTzpUJVd6bzs4EEbT24BAfZrXuLOyy00i9UJcFxtVygY3TPTsNrX3z5DayiZo0gIPGy4tynaV7Xu94u8umft3xY5fisbrxkEy8mfEJzPmN3b2W/C8x7+wJSkmSb+8ogeuEvf5PDShCZAQIgPOVBhUXloQUMe7guQjdwI9Qwxyw==
X-YMail-OSG: OYLFMGAVM1kZYN.3iM_5zn8_DOsruRrQ4byyGbfb4Jozmia_03Mjcobgvds.pnY
 IR_a89Szfn4AxDMLq_CzjrA6bq77gdPIVUP_PcKeCPaxufpHcVewazuG7h8MGTjYwfmH63mbgT3h
 1deT5fu44XmvNR3jARwDdn_k_m3gZcrXmdT.F5Y4OPW_Kd7HdUd6yv0I1ZrNoAivtI5uYsMdvOlO
 eNGe0LBWpqkKwBp.64cmJ5hve.F8AtOHwZ27S1fpEE3q_JUP9T.UkQMdDs4EKg3n.Jn6OzJ_z7xy
 ZDHyurRfJ9D4VGvEC9JH2QQIwZ_B1JU.tWQipoXjBuu.5HXYLGM4EempXY5UE9Jd3FWzXGkGLlSj
 GmvwCsVcv6EGJvNMzyKyjLiB9RtO6CeS7OIMFGRU9Fs.7PTIwcm4pqd_aeim_s096Zs.Bf3Pjr4O
 mK6.zohNkPGdoaiCdwC9BSc_x0bybDaOD9RThKnbK_eZJdwJYWrDepZw1y2kUq1ETo3J4aoqw7o.
 4UP5HdC6udXeQrp0TOcNK7SBDAakuZ9awdf4VcNiFYcmbhEPyl28fTkgibSoEGIkMJjX62Hg2DZ_
 oJS43PVrZsItuS4MjPdGBn6etTtQqhTEJvIpFDZHtbINqfoMZgz.VlVF9vlELLhJzFA6DLBxhUiF
 i1i4JqsfSt0_VqX3TIF2KKG1GViS48RDl14cQAk1UG4UYsEBlkPX7XSLkwlpLp5oXU4dXtr_3n6A
 29B7KHBa24sklevs00yUTdWyCn4MZpzDO29hHq0dRkOMBPupDE39_h3vdw7Ksw8drMwEiGWfzKKd
 RqvCYN9OyC3hr82ruFKlOj_5ir908d6PZ4hbtoso4zoZPb8g0oPiddJ8MBMqPT5u3gvT8bEccidW
 EibY1AJsJc4xUS8SEMCOpZb2XRi6f9k4uHqqHcl.l09X0Rk_5jtbpg842i6pzGMW5Sg_JtkVMlme
 zJmTHc2bC5DDScAA368spxEMHw7.SdakU4lKjC7oTU.6kBfcqASwjgVe6ktNsc1tCPMT010OVU0z
 xodVM7fly8eg5LCpgADKacuya9Jk9UVcDbeAm8S2__YV4m4uS497I2dcn7nyF4HtvKceJ3Jmmf8V
 dRzjf7sUD_mZOarSAmlU8oaUKK4vJSuY1qrGNMg2BQmWdeEYSOhBFWeDhblZ31fyPp7.bKhCnlGn
 zj_3_FZfOHYqzDBxTMsEEYCICTo1CWNwOmdO9rQu1dQ7UfD30kOip4.fzETD0Lc6J0Nu.b.xjv8e
 JTmbNutumRCHKLvztmv16xTfReKk4H3W7dlHm.2l6V_O8622YgWku5VA6bahuQMSfZViGeVHtcwa
 z2Mr8Hsd9ayAZPkCpqpJv.FBowN418BJ1dT074RzjfUY6G9MkmN2ZwZ8kRbpvssP1hZsK6O.V878
 Tnhy3jaUvHFIwwBWTTujh0sIUhldBCkb1P2pudnVLv1fdyOVi2cFQqf4TC6rEI.ijy6LbRsxZCSq
 gdTOU9vkcd7Tleryo4sSNGM7sVzpj552M_eA0XKFNG905JpXD6MP0BO3P8rGJMO6Ga3ARuqWiu_T
 AU_ekav0TuG6ANzfmXdzlG8Bd4itaEJ7IxiMlevEjHcDCheaIk0OnSQAw_1_4qlP9niKWLQ3CCF2
 Qke8BHixI.n45eSjOXzKP5weJV0goFF.CqPM6v.cTlgCHQbWrL1eSxxmjMNKe2HagdYA2duf1d6S
 Th1aRejy.AARldfWuXK9OadCuavtEcid7bpDlUD_8M0U9AcaI9S5ybfxRXJO0DryRgb4w3hVZLZg
 eSUNufEWZT4rvZ5dnqkP5N96Esq7QqYkFVLjNP6Mqg4hGKiMDc1v6Lka.ns9CTkiPpouQ2suGDjf
 0rJEEpLbQkJqADszd0Hcibv_KK0mpsKJmBffmWxFbiLwvEJzeOBMHMV9RThbE97vqkjzye03E4QC
 tCUDo5IQnANJ0aJmT4rlzIs_vcNkOwGdgNSlfO67LDQ1cFluA9m4YWtUPg9EsJxhu.8CCI.RXDZO
 IxzlHhRWGHt2kSmB6vSr.k61Ly0HqqfJLVmNpjtEHkPY7KlBVSeQ.l6fYTnZ3RCJ8Mx04pMBrE1Q
 lNV4cJo8c_KpNskQrP1k.8GrZ7INALrdikQgLbYRJ5LLW7XucO8dHNfltxmEIr3e7Tdv95TzEFbu
 n7yCA6i4GnJgIakWCR34qmtogx3pLjW68sXaNhbVvpsr1AWIIq_29TkcG741e8FBh6b1fA08PuMZ
 gbePrGK9GP1DFY_TBtvA5_V2AAcz.dX1OBA--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
X-Sonic-ID: 3d9ce211-70a7-4ce0-bdf8-081fc28b8cac
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 23 Sep 2024 15:50:08 +0000
Received: by hermes--production-bf1-774ddfff8-ngpsq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 62e3e597125d17114edee27831191129;
          Mon, 23 Sep 2024 15:09:41 +0000 (UTC)
Date: Mon, 23 Sep 2024 11:09:32 -0400
From: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: AMD SME fails boot after "dma-mapping: direct calls for dma-iommu"
To: Leon Romanovsky <leon@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1727103770.hoytxrqcmg.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1727103770.hoytxrqcmg.none.ref@localhost>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi all,

Recently on torvalds master my ASRock B450 Pro4 with Ryzen 1600 cannot=20
boot with mem_encrypt=3Don. Bisect blames "dma-mapping: direct calls for=20
dma-iommu".

Let me know what further information is needed to troubleshoot this=20
issue.

Thanks,
Alex.

