Return-Path: <linux-kernel+bounces-290870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8A955A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 00:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1CC1C20B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 22:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D9F148302;
	Sat, 17 Aug 2024 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="O9OQgmBP"
Received: from sonic309-21.consmr.mail.gq1.yahoo.com (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BDD13CFA3
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723935283; cv=none; b=XHv1iJTnQBdifSgpi0lMrulLlKCIMitk2zPqeUH1de/g/EcZTFQ32deTsU2ap17eM2ZOQ5lqZN+Dv7RjIfKVsjeohn1FhPA3X30vvkFILqZ/q83qyo89GQhl5Xw7xpp6PEjmLAA71PdRTJwBZlDVnb5Yiinh7wTC30xiEt5e2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723935283; c=relaxed/simple;
	bh=6lb+9zD27B83cWX4iohHkNtiprizq49opiFkrMjgejE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type:References; b=jkYEq3pTy5UCXBabamfzPGcCTHcB80MM3aIB7FnCxW4GThSElFJ2p2jwiMYDzjGFl0PzdKo7CLDmIDF+cwgrcA6H1LzE/veblpj2dea5FICrT6MEQwQvx5bPpelkyPPdyEj2gBJlisArgBrs4bFODFp+0CvKKChdfqUUY624Yj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=O9OQgmBP; arc=none smtp.client-ip=98.137.65.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723935281; bh=6lb+9zD27B83cWX4iohHkNtiprizq49opiFkrMjgejE=; h=Date:From:To:Cc:In-Reply-To:Subject:References:From:Subject:Reply-To; b=O9OQgmBPg19kp2rgTij5zw14D5v6AE1Z4N97zAYaiHpqMwXEwR88fedvrqgX4gJbCHRrhsRCryNIqK0wCYmbJMqzFUmCYTnb+GR3zX9yt18rxPdUEudQtTpRhsmObcntQrox0d7tfOJM+vjyXpeS5Bi/E0XZxvqXi8lyCjejzO44o8J3Kin4KePEYrvmN5WGe3CjdBhB/k8/HCUE1HSgP+zUiNGYJG0oEGmjRFSg+4ibet5aljSUWZ8DUB1ywz6g/5Urp5VjFrrZMFIPiqX0cRb0+fZ35kz5F0AKnCXdYG/EG3n7ULmz2Vz9dHiJB/053xbj6wQHjZGg72zBy17Sqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723935281; bh=LgL8l857r0MQAl7MVN6T4e3R8Z+9eOeylNleIWcNVRx=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=aZXVfA6fB/hDS2UoYy1UoaTUSJ8G3argqzIq54B8E4OXUoDjG6c/Q7vfmJ8Yq2D0Ex04CHpzgM4XXiviBYWrw+H2tQuHiWWL84T1nFFrhHGWTolF+aTq/A5L+izn0nzrbdgdav4AcEDVwKNKrKZI3+Wevqn09ppmpszc47PgSgnNBvpG9OfHe2LxMjiJIyolIeXaaYrlj7hCmduWqKW/Mw0jkDjrxu+sdfj4PAfuedRAUXyq9MqyZc9YEXP9beRL+vi6kqKbzauDqOfSOb5S5JfikUKZ/iG++KnAT95OXmy7Js/W20AfADlNU6pwAzUGyxEti5VbuUvCAz8chQ7VIA==
X-YMail-OSG: bohftxUVM1k0Q_K095NG_VPwORNYoC3r_36ZESJOYi7nqNkD9cEXAs7B1HnV0oP
 EfoxHiN_8XMuzw_SKKyQaBdb.7keehmYsi9YV6hULeE4z0B4rexxZhLOksJFZYm.Lw4PeXuscZyi
 UwAlpZFxWI5Xdp7SiwRMTbDS9myhKSBSBRjG1xkzpBKQr765P6Y.cQTs2hq49lgiOtM2zOV1oV85
 D9u0AlP9M5lfFcvtCib6TEq7Pznt0swzKkjtLenuL5zdXS6bkgpZxoNnEXLXGFMLBVYyPiNOlQwp
 zhfxryvOduNFuzGDBRx84kLPBomEtfR7yP7OSXKPrxW01zD1fnjL88KBFosJsMG5.ZIjgTdhIpsZ
 o_F0yToYgxknrSi9BgP3D13tkssrBBdZ_L3LNxHbs55f8qKdFtlLqYDMwTmoNQ1piTGSNTaJrlrx
 sYrSU3MIHZgYMVVQr35kErLbAtGAJDBPP.1kqedtKWQiZX1jdyBXlC7XCfJyWu7hn5LP9akElokV
 few3FLOPNjEoJLVFvebYmXEjfAbtIY7eU6g36pirlNbsqJC75czddj8kge6bR.yLyFBcNrbO_ED4
 fpmVhtenUeumfsCLDOLYVr_aFGI4dKp00Oz8fAdj.OsHvZ3LDL93V5YN49xLScd2ovy8Zl6cHl7x
 3DUDMbn66Pr0HiM9VKmxs8liFI3b2yzvMjDGd2QhkK1MyB5RxuvhpvPCey58ACtXi7GUWkR12pjW
 CqPXruG71sBzgAsohfChTvt2u_2u81kIBU9WC8QSHC_0ypsOTNDilD6OX7McO.tRh37hIlaqGggc
 iVQMlwevZ4iKTy3kLgekmXAYAdzYhdh3vaK3bfEUWojiv3B7QQQ1pF072a02j8DGlhYfmnfcuh.0
 Tcw_JlLIlsy5TrYdJ_Gtb_0SuP_q2ToLf4U6Gr.LeoJLSVryfOBfnZcvQ6_9.Z6vw1Nu6EGdK1jC
 3_27sW1V8NvBmfydwrWVhvn3hWBPnKiWMExzLmESGLpDSD3sAqyxXTIPKZ7.NuiwknVlGX5xMioo
 _L1AaG.Wktxhqn2BqQNN9KIT3Hr484Opiu2SWFqUTLsmg.OFaS6D0h.0wAKQLCWCBs9dNR_kY5Q2
 NOnmLvJ8kaBNPE.X2R8cG9BJZsT720DXvRgzd_J8kqrmed9gvLySIkqK9yodsaVEZ5tjuNem07Qb
 AJwlnqr.6DZRiafR0sDp6z8Bd0M5v_ukBaNetxqkgalL7Ehi.kLlqjEq7IOQlGTXqgZFaUAdMYD7
 Fc2liWomcgAlwT8Szs7Lk_LaTXZdu3FTy1pkkCLUG6_8ME2gc4Mn.v7CAeLDePqpa5dgtMREOigy
 .l.NqeNRrXhQFz5XPnoJ4AMcpAKzDv9r_ybUvs7FbzxwjtGklRoGGujD4q3ZbPCmhTYoSgZEkA8B
 y9TvmQ3c8.3yTmNI2xDJHrpjIg3MfvbYIVYwDNkWnR_5GW9O1weQpIqCiiWVu9e4QAC7TpnDGQTm
 5QKyUXZp04JqGNvBUM_Ba5ZNAKOp3vk.MvcHyZ9r5wj_SKlt7wP.i8xxDyptzHH_LJ9Ybx5nmQob
 vVjft96HWb0os8HW8SlJl6ts4BNPRHpLVsQk2sNF0Wg5jBaTFi0Pe0jRBQGx2cRYuPSVSpgEnLFz
 ihy3IB8HMNocy_2m7ZZLm5mlBvIw753Gc9o8GVl0y_8uACW.TWhwDY3jMW.UxI3p4xU55XxGlEfD
 _tGesTgz5y3fvPrOFRCzIah.c6Lb5cY.hmGmKZNeP7UqSiGvyNUFIMD5vX2cWGje4rPRvQxmSZhO
 Q3TakZ33uyjasOjY2.1tHAtaF3L30LEqBMq6D75ecnS5u77ug14LE.WLNeyiH38q69reQb2VJwXT
 Pgku5L_2FcdAFTr8QTWbqMtWfzTxOcnRzA8ZkQ1JGXgLOwSpbeU_A3UWTuEJ3LoDV7D.FlTo_UAa
 97IKlmAVQkeAFNZwLIiGig0gu4fCbetjOEgm4IEw9VPMsxdxbJHoxyisf2u6UghwTkXU8l3Ytjz9
 0GmxNjdJfoYJwXuMbQlF2APegjIXHWUNQqbdhPKHjbYnG5uYDODiaCDU3FvSX9FbdwYcsR5yfetz
 D2hx9N_WUtrOOMOxnOMLovELCWQ3CsNmXqOwmV6CCRds5qUfOuYpymoRqYYQyJp2Qutdmq7Fkrph
 j_OSTAjxq_bIawSw31jgX1R7Ph9._xJUxzeQTTB6KP7YFXivjifklWV3H4RQy7RqafVzzpXQ27kc
 WuhJDAYNEC3oIcZDftl.PORo9cRUdhhhtpogxbot3mggBIOkX3E__00TJYbRYCH6ZFM3WGtPSude
 WsTzljde7Px0-
X-Sonic-MF: <Djedhi@yahoo.com>
X-Sonic-ID: d2a03a52-0ab2-4eea-afdd-1759c8ecbafb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Aug 2024 22:54:41 +0000
Received: by hermes--production-gq1-5d95dc458-vkwd9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fd393252169a0d5a514d5f4e09acc3df;
          Sat, 17 Aug 2024 22:44:31 +0000 (UTC)
Date: Sat, 17 Aug 2024 15:44:25 -0700 (PDT)
From: Michael <Djedhi@yahoo.com>
To: puranjay@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	catalin.marinas@arm.com, daniel@iogearbox.net, eddyz87@gmail.com,
	haoluo@google.com, jean-philippe@linaro.org,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, puranjay12@gmail.com, sdf@fomichev.me,
	song@kernel.org, will@kernel.org, xukuohai@huaweicloud.com,
	yonghong.song@linux.dev
Message-ID: <8624599b-0431-4e37-8e12-5bbacc046c49@yahoo.com>
In-Reply-To: <20240711151838.43469-1-puranjay@kernel.org>
Subject: Re: [PATCH bpf] bpf, arm64: fix trampoline for
 BPF_TRAMP_F_CALL_ORIG
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
X-Correlation-ID: <8624599b-0431-4e37-8e12-5bbacc046c49@yahoo.com>
References: <8624599b-0431-4e37-8e12-5bbacc046c49.ref@yahoo.com>
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


git send-email \
=C2=A0=C2=A0=C2=A0 --in-reply-to=3D20240711151838.43469-1-puranjay@kernel.o=
rg \
=C2=A0=C2=A0=C2=A0 --to=3Dpuranjay@kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dandrii@kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dast@kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dbpf@vger.kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dcatalin.marinas@arm.com \
=C2=A0=C2=A0=C2=A0 --cc=3Ddaniel@iogearbox.net \
=C2=A0=C2=A0=C2=A0 --cc=3Deddyz87@gmail.com \
=C2=A0=C2=A0=C2=A0 --cc=3Dhaoluo@google.com \
=C2=A0=C2=A0=C2=A0 --cc=3Djean-philippe@linaro.org \
=C2=A0=C2=A0=C2=A0 --cc=3Djohn.fastabend@gmail.com \
=C2=A0=C2=A0=C2=A0 --cc=3Djolsa@kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dkpsingh@kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dlinux-arm-kernel@lists.infradead.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dlinux-kernel@vger.kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dmartin.lau@linux.dev \
=C2=A0=C2=A0=C2=A0 --cc=3Dpuranjay12@gmail.com \
=C2=A0=C2=A0=C2=A0 --cc=3Dsdf@fomichev.me \
=C2=A0=C2=A0=C2=A0 --cc=3Dsong@kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dwill@kernel.org \
=C2=A0=C2=A0=C2=A0 --cc=3Dxukuohai@huaweicloud.com \
=C2=A0=C2=A0=C2=A0 --cc=3Dyonghong.song@linux.dev \
=C2=A0=C2=A0=C2=A0 /path/to/YOUR_REPLY

