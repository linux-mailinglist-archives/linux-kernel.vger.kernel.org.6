Return-Path: <linux-kernel+bounces-290873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A0955A47
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 01:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE5A1F21D95
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 23:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD316156654;
	Sat, 17 Aug 2024 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="K3P1AraU"
Received: from sonic317-21.consmr.mail.gq1.yahoo.com (sonic317-21.consmr.mail.gq1.yahoo.com [98.137.66.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCF156230
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.66.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723936198; cv=none; b=Oq37Iz7eTcpH/soXafkyvEXd3rEdWkmVK9QvocsXaA2XBywIoYoFcXg7icMZcNmKWZu8wS5CT0jzodjdU4B4h8EI0GMZbJQW+Mn7ZGIZ/B5ocJioPW+i3WBUFt0yiwM8YXPRze4CehkPXB14duCEA4dbYdfJ2VRNIU4RFuQVsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723936198; c=relaxed/simple;
	bh=mQgw9icLT0W5XmyAAFY6W+/kZ4M0KqI/bQypWxp/PdA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type:References; b=uRgk13zAoTZRTdfnPJNP+V5OFOMqOPwJQV9bOA+ZvaY6dQOF6u0ac38HjUEjffDAXm0GDSOrebHMrrLm2hwdy5ZmimgXq2eYTJ9i9msW6Y92Mb+EX9WvL83aQ2jIYRDuu8G9gsQLizP7qPD65ThWgh3CueYAp8E9iPGvfcW0KlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=K3P1AraU; arc=none smtp.client-ip=98.137.66.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723936196; bh=mQgw9icLT0W5XmyAAFY6W+/kZ4M0KqI/bQypWxp/PdA=; h=Date:From:To:Cc:In-Reply-To:Subject:References:From:Subject:Reply-To; b=K3P1AraU4Y7u7cQuauqHs6s7lhL+uiRxdh0xliDA5VhHF1gIWOXscnk+/yZhpccz8r7wrdFEGRLNkN/knP7cIz7ufGTmXMNoBVVHAvZybFUcwVm++w3jckNdXDeXOSm34ABp9DdoJk4Rr6iesekdAzL5RU7gz6KmeqLEkRcfmPons7RLQn47e3UCeIhxYohda/bf3RKFbHhoFrtypO8UAiuvGseHxhuFaebISVAmHrOA8JDT95xFU4BGUZFrbRVrDVP7m3o4Lyc5zmXJvB7QRj4ZZDmq1xbrOECeb5ohCTvxjnB7ivoPABKKGepIk4fPnDOVjaK/TJjhObWy4VIxaA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723936196; bh=5grBUw7BKlxU5mDmecBJIiJ8sw0Kg6tfNmMIOboMuhz=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ID+p/FM2VeqZqGcLUF994Z8UqNqaZBJ/RpRp4410kMHlcOyebUOWC19BX5duD89isIysUybglcl7NKOUV1dXa0a3+HC6ODb6oSOWlEaldiKT9iOHjW7WTlTojpb3jrdpl5N32UKOoortujVH3FEI1RQNA2JCGUUngfK0GDIP70EdyLW5WENA7rDS3n5Aq9aDhk4At3fIkHfW8PsJE+xSU/4LzAmQN5yZXtuxzbEIgyMro0SUzdrQ1+1iz20eTGkUR5vrYOypf3NTbR/nhmLf1vBjzpc7YByAdU1xPZD49oEPlIoEb3Lg6lexyx3ylz817AW6rsXwDNwfz7VBQhO/mg==
X-YMail-OSG: lE.Nc3YVM1kYRiMwOUT7aTVBpm3zB92Rcd1qoh6Rfm9O6F21iIRcsgYkIO4XazV
 1sPSRPdE2HMMbD850xFlVwm9a7XrD1m1M9YEq9Zz0vsAbqh0swUCnT1J2oSv2Rfx.1nwFYPJ1tZY
 nwGiUduOPqPsF2Lsg9HxcKBI6tnqlAkrEpu_hYLbk.oKk5cGkkrksKoBOkTLDgQOVPnvl1MvTVS8
 WXUdHWaDjJ9FDzrX25CuWgK5ziIxQlXwcqojQXmljJZCV0CL.MVhe3Wy8hzgobGuN_MZJuAxdV36
 ZcyGw2uBth94yXZOdapckdNu2vH0T5zFornlG7dEr2RQERQKgFWWtBlNHw2bofH3Z5u8CyUm2hRx
 CGDsNnrJluCHs1CQ8KhmzE6zbXUPpmd8pW9lMiuZeC.YaTeffyvUFM7Z40kKmiwh3fgBXnRkxY7C
 HbcGoGzQDc10ia.dqs9jZKplRsAdnQdis.9MMfKHZOIojn3Mbix8lVPkNAIboSMGi5O9i1IhOKlu
 deGC5lOudimkjuqd5fE1b6SdNohXfH5KWWoheAbUIlikYO3B14f9J5txSE82OJOCAU0mmixrV99t
 MWe19siPwW7nWIEQzrIH1e_VZmzSmvt0KkGAfJquejqD1P3sRNYN9pwDNHpcGHUNqbk.EBzrhXDI
 QF3OxiiB8qVQms7ugu8YxI4XmHffGOgv.UmFoqJzVCyDVYYmXcrnh5EZ9ajv9bVe7c0Rix9fp7r1
 t_dOPxDG8Fcp3GKWugBXjFu9WpooFEdbybzi.33K5yoePXdh.xF5RTLuYTdj0F98MuF8ojGvNmXV
 mufg.HNNQrT4Ob45mgEnEJp.dajQx5A2CK24LSVirIgMago7AYcxRbVpP24YuQsp5r8NEReuO5d.
 VlnvPLIwHOrqaTmdMBOpwyAjfq4.f9.rCjpzs..Lsq809fzr5dDbyz4VgqjiZjWB5SebhRTaa1k0
 .XPGriGitobJnoJn1zkLQSk5fn5tS6.QhINo8nFQ8wfIxalRKQWeycZ_YmpsLsK2wKKFbtwbAn1m
 rsCUxq89kYQ0BIMenpOO62zDHp2r.CtNZlqtCEZ2IPRO0alJzpHFraVvhVvPtkFsLXvTfDWEn3Am
 SMnF5DyBqn7T1o6lUgtQPWLRAt.EwWlrtxqReY.QAlNCqJsraUnITqdaH3.lg5Huk4sKW.iYdNaw
 ETl0ifHIT6_FAlbhTA1wBOGrFBYy8y6XxNANDiiSlhCxtUqBHBTVnHGKqIFpVj8jsXbMLuI7KYB9
 E2K7VVCrVv0Q2KiYTGv0xQfr8rWfC3O3KHPwN0rzA8gead6Z3hnx9SRxArpVrzZJ8kURzQae3QHc
 4UGHKIgpHEp3fTZf7bZy7qeS1.lpw_jPE.59GObGHB1lC.0am69C7z_HijiuBE8l21p.QZUGzVLI
 FVOH.CPaBG3vknK8s6GT57RmlT2apP_jJEim7WITCXjzhNa7iPDqBY31WOthssc.r0HW4ULxOi1Q
 VwK3s_nFKpffgFGc6NkLlmFvfxXLy7leKvgwWiXCoUnG778Qrv0SLX_qGYS_z5LL6o5nr6kDBv7f
 04AhKaJ.yExqgNWVDMW7mFLK3FgadLinc6_s2mQF5X61rNfCwz8W4VlBha_zoHomS28cpnr2_xgU
 UBk6XEG2sUFIGM3NUoPwKlHJRdimIBBoBSxxYwQhxo3l.9iScaYZWybgjsmSq9PtLTZY1jpnqdTv
 s4Qk.JGN_xwmjmjzYVzkDhfgxDe99kePBfF_cpy5jtwKv6AnT8Q2WXZz4sUMXL5Xf2MpX4OAqkjT
 .b6LdAJGKEow2IBqgQ13bMS74StK.Gik1D2VI9SWBG1Vo1TJGKIAAYW4k7IwoIFWtkceAQAXkjeH
 sFECv.2pIl2qrDa6CyHnPuR5zbfbDBhZEK0MDWfy2XF7ALK6ZkR0FrGRwkz68HRojfc6_omtI_MQ
 7tSnbALXPjRNZtxwzB3MavtX5SwmRqHsTNgLW62JK4dmkicgzjo_ONlJdaEYY_hC0ucc.HGQKkRH
 J46xAj0lcXJ58xkEQn4mXD_aufzTvDkJ0YEvGUroPHcvgxsTgtBHJ.DnqkbOEfVSYEu2obnx6ybt
 N6oZici6fNtNtb.KLxQxSpS3g_viNTcxndLU9f1Cid6Hxung_OGJatlN79mu7WAbDKXgtmO.ZdYV
 gFutft_Fl9WDujA_e40mYNVO2Dr.HQiCHHt4GHyaK8XdRDVFAQ7zhuFpmeWCI5btR9651cmshh55
 aIfo1l9Bd9zA3j.99CShRESMZ4OYIZ0ET7KnAFvut7YiTjteSgkp3Nr4Q4lYxXMZDZL_4Kg487IM
 B5_CHMJkA67i17kaMDguL8G5NJPMyR3Txpw--
X-Sonic-MF: <Djedhi@yahoo.com>
X-Sonic-ID: 90dfa20a-417d-445a-aea2-e603eb6b64fe
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Aug 2024 23:09:56 +0000
Received: by hermes--production-gq1-5d95dc458-c8wt4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 996e7bc092d72e2d364d7d366e007daf;
          Sat, 17 Aug 2024 22:49:40 +0000 (UTC)
Date: Sat, 17 Aug 2024 15:49:34 -0700 (PDT)
From: Michael <Djedhi@yahoo.com>
To: linan666@huaweicloud.com
Cc: houtao1@huawei.com, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, song@kernel.org, yangerkun@huawei.com,
	yi.zhang@huawei.com, yukuai3@huawei.com
Message-ID: <361df5b6-c838-4f21-8651-9962dd1f55b8@yahoo.com>
In-Reply-To: <20240525185257.3896201-3-linan666@huaweicloud.com>
Subject: Re: [PATCH 2/2] md: fix deadlock between mddev_suspend and flush
 bio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Importance: High
Priority: Urgent
X-Priority: 1
Sensitivity: Private
X-Correlation-ID: <361df5b6-c838-4f21-8651-9962dd1f55b8@yahoo.com>
References: <361df5b6-c838-4f21-8651-9962dd1f55b8.ref@yahoo.com>
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


git send-email \
=C2=A0=C2=A0=C2=A0 --in-reply-to=3D20240525185257.3896201-3-linan666@huawei=
cloud.com \
=C2=A0=C2=A0=C2=A0 --to=3Dlinan666@huaweicloud.com \
=C2=A0=C2=A0=C2=A0 --cc=3Dhoutao1@huawei.com \
=C2=A0=C2=A0=C2=A0 --cc=3Dlinux-kernel@vger.kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dlinux-raid@vger.kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dsong@kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dyangerkun@huawei.com \
=C2=A0=C2=A0=C2=A0 --cc=3Dyi.zhang@huawei.com \
=C2=A0=C2=A0=C2=A0 --cc=3Dyukuai3@huawei.com \
=C2=A0=C2=A0=C2=A0 /path/to/YOUR_REPLY

