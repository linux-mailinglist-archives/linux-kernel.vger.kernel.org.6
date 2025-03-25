Return-Path: <linux-kernel+bounces-575805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638A8A70761
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18DF1674A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F2325E806;
	Tue, 25 Mar 2025 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Do5wJDFR"
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74D84FAD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921500; cv=none; b=Fs+/3ANLF3zFHecAydKnxb+OU/VJ01hpVB3n9N886kY+EzyipmhXfB/HpI47hd5e96yS2IEO4h1WIUkVNaomCdn2uFUkIQS/xXCL6++8eN5GJDsrAgC9rslXiFtqFdBY3CPa0cyILfIXHXPspoZLmSGBMdATGv1IThS2mOAtfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921500; c=relaxed/simple;
	bh=jS67oAesz1Y8NauC3CC0XT71C2aVOdBEhvuvi52kWMg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=CTeslpH2q8PXoovbO7H1kYY87TmnNyF0UaXKDl7KpjIHmNBsEAMZg8B2+3vbLMXtD0GgJxgcVyf+gKsImE+hDYFsAITZmGQEkUTTJKrDey4ACBdOZyrbkuNSFTqdH678IvfRYGYLgNHrRrQTv7mKZTs6/EMvSriz1xLRgYIAEaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Do5wJDFR; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742921491; bh=IdykXTVI7p69c2IyaMS+lYXEfvBTHgFMPP9Erx27P4c=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=Do5wJDFR01AaJfLREnOtFUnp82EGZpYfLuMxXWhafPe/0oiyBj+0VTz24pp7VOy43OL8GUKd1bFUbEFWh+ILGmUj9E7JpU6MR7dDqwzT+Y0c9qFtq3v1W40GkqnM9iqZ4SpQaWO98iAKdmx2ocWgWdocQWb2zqF1Ocf2vkf4/iaMjO4zgKDH2rPfkp+dXxzuealN6BUEwvbKLj3ZxCQ40fmu+y8cnhRr8tX3Fj9+WgavszzB0aMmUfan+rFvF69R2QdMd1rgtGblfR0w2ODAq6c4OLaC9wgS/MhzfNsP1gomodShOjpn97UM/jAtdqZ5Qr4RcOFYvN8OderVjLeKtQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742921491; bh=+v6/nsJd6JeZ3hJavmMCP+2MCqUW/slCYXNkro7O3iP=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=dvnx/CYoVgyVl8kN8645zYyCyLMoRoiJCgUKsu4xq+0FB1mthWtj2FkRUomJwkuYQKHjHgKT2hYskZ+YIYWEFHj6vILtHkpmeiLROtMS0e+kMdfu9hZMLvOH0YNAhck/lsTS/fBn7KXFByOKY+EP+zmBlMA/RwAXwRYgm2j5FkJ0zXd1EBGCHmxV4eF/TWf2JLzIS+SnCQW5ZrYno7MR3phL02U/V74z3NGyghAVIJ5q+2RvIP6rpF4qm/zYhmvypfSw1136K2J9lWyO4z6DPeu+drpXxSgtkuVgTpTlHyELnfhHQJCB84Bno7t5BpDEU8453lbydT1bRPcftXmCww==
X-YMail-OSG: hh8J610VM1nn8Q7n2Y0stMAoO0augQKmaIrHkmErDYZt7wtQyW3SQ472oFrbEdL
 172vHTm6gsX6GkSiBt5xzb.4WC2nlSkUTPuT8NCt_Wd2RJXWPT7jUN64X6a7JIMzqOflZODcLu0m
 frtHIYnjtHNlnfU1_YKz48.44WUApWeXErcbYj2H3M.OpXqFQKuK6Wn2VuhORh8nRXl9rWO9FTGb
 MPT3lVjR5B5hmIn2xB1LlZVg7puXQndIrSsklIAm82aEDYcFQeh3a456DxDfTAkymRHRM1RInI2Y
 gdoB55ixNUGexCYPsqfpHrQNZG7jJNwWAq_2xU4Ax4UNCR22Zqu.rrfCAQow7PzuR6SJ1UVppGB0
 _lHYMqiHP4A3zYnmut2urA0tx5dXV08irSB2RV_0.N1R8S3Yiw4I5NfkBBfoS.qC4DsEoOCA_r_Y
 Edz_epOVydesNXsQF.l8xRP_eSy7c0X9g3KxNJeBCKLgXDg9XpHEy2cAN8N3a18TqPZlAWtv.agk
 qKA_N4P26nxGwnHRqYwDtx8GifL7YvSSfXth8KWE90k7bgdzaUYO2Ull8J0ECiBuhfPQMDFKHIrb
 ETIUWr1jKaMND._PFX4j6E6KFDr1Vj.4b0nf.XmRkUbcu50xPZUfVczPtBjWGlpsWEIYRKg7VcIs
 ewI6J8zsttK54RzO5HSbjV3x7kzPYsDkYQ1Pulgt0WB8rxnZ1XDMIJLzMBHob6l0SsES1zzvtLjX
 G2_EfAXB6VhuYmmSfZJh.F1YrlnXotjUUv9lQwGCQt_veKn89NOJ4j_rzN_08UOBl5cUAyBrdLO3
 AWYsM2LCnAXdWU2blQ1Jx.ELIIIJg8NA1.Ixi_lp7iDibtc1ABci46MrfEEi7HnyO8Ecdb2AlnAH
 G1Vl.0Rb.kpP_xn05o893LewqRyv9DsHy8M1tjlN9BLH_TWeVfDSakxT8UUiefCIUpdqG91BQMNj
 AJb7WcWnHQ5S3NPViV1F6rfPg23qVHiOg2PVlK2d6D5dL51HQXunFDLsvmO47A6WThZhNG2lnpUG
 12zCeCXNTcr.z5Sbg5O404sYPHGRCT30gixj6QYo4IhjcpybVh0ZRmIsCKxe01njBxQDQZfn6hQ8
 rbB_mvHpVsEyyNbpUSnV4YfO4DnIvsVXrcWrVvD51tVSbPrc6awbDXI7knaNEBqK39Lq_.I_9_od
 AguP702uuI7PwPQCIeKaq7C7XyQTZ3OTGXoquT00I002RDVqzgiB.TxWJ_VhE5pT7iBl1lxKKqVc
 ECWUAi8KuUMmDPqXUl.JzNGl3LYdhyZc8c3b.gk3cfEYv.iy.HejHFpTU_qzZruqjU_cTvjzRH3N
 OZtmkO7z7csyxOM_jvjhIX8AtAJP2evmC_NP4O1bngIX2YG9ktfxGf.LnhlbRWFntzQ2Ck4KOlIN
 26AAUqaf8IgXKO2mcp7nizf2UsRQf2Gu6pr7IarlyMatzsaLXjh7VBWd4hl9B80.DtOo.7ROaSLf
 phyt6T99ZzdrbcoJ4xu.Jty07IPPEpreDrUPviB0ckLJ9mezlmv_hqQqxLBWDsDWza04gRCpH_if
 1zR_4Cl9ReXCrSkfoPlhISMbPGhfywGq_QC2qODNrlHjncuwK4ZSCK48VsFUB3WfMRdNhCucyE0d
 0P.fnON.S299u1WlCCP6o1F5BxAnHxvP9yMt4A4VrRZ40EGTLW9qhy7kIWkX0Boc4_q7o56lRH7i
 WlLCJ8j4AZ7K6SGv0p3hQQsYRRtl8XFnJ1qsGc8wcs4I.eqPq6J2VjZOCThL41RqqJtiD1M3wpGa
 kJaDQLAF_1Vr6R8omJZfojQ9uIDa2NU9V_l4kbuuN7V0r93pRP3swyPBPMXytxBPtYMp7QdLKM1D
 L8TcVrsqj97YI1X70oK82IteSsjWIuz6qhEeO6Fr1gfR_Ub9pGHDZHB.LfUJoNN2pmyIWjF_esuu
 f.X9.2vmoVNYSSWb3AUM3XaYIKuq1vXHkpJ3rLLmaEP7Z3wIhWXOE0G1kVGtKoTWT21XPry8oEFP
 dL.Pda8LeZCpzyPAnMJRH_5zrayqwVvDZnCsEgK7.loH.uNMe93kj5hVwUcM1RL92AD0_7FdQAlR
 W0K.Rk1yUDrRlfMcPR8K2yPms6AespA0nw4sj5pO.CJ2FtqSjvKRx6V6EJThkAntGkfEuwbb1DV4
 OHNEryIONgrRg63e048KkFWjOZ13fAn3KIypmm2Hug1fsdsid4HaBRjh4kvosCxgyCS9I5z5iJJm
 Z5_0KsdFt8ZdRJ6toeOL7DQQ.OebtnUKCzr0MN.d3sC1W0QKVndEzeKNOfTi7e1cQRJdXHewS1ym
 0axDhl84NF3B5DUKDL9lFCw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 18af2867-df7f-47b9-ba43-8f57eb44f25f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Mar 2025 16:51:31 +0000
Received: by hermes--production-gq1-5c477bf655-s8xr7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4653def2fdc5d2c09a7af09c5b8d8672;
          Tue, 25 Mar 2025 16:41:21 +0000 (UTC)
Message-ID: <8040a0e7-2121-4389-88e5-c6f209bfca0a@schaufler-ca.com>
Date: Tue, 25 Mar 2025 09:41:19 -0700
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
 konstantin Andreev <andreev@swemel.ru>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <8040a0e7-2121-4389-88e5-c6f209bfca0a.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.23533 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Linus,

Here is the Smack pull request for v6.15.

This is a larger set of patches than usual. It consists of
a set of build clean-ups, a rework of error handling in setting
up CIPSO label specification and a bug fix in network labeling.
All have been tested and in next for some time.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.15

for you to fetch changes up to a158a937d864d0034fea14913c1f09c6d5f574b8:

  smack: recognize ipv4 CIPSO w/o categories (2025-02-16 14:17:55 -0800)

----------------------------------------------------------------
Smack patches for v6.15

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: fix typos and spelling errors

Konstantin Andreev (5):
      smack: dont compile ipv6 code unless ipv6 is configured
      smack: ipv4/ipv6: tcp/dccp/sctp: fix incorrect child socket label
      smack: remove /smack/logging if audit is not configured
      smack: Revert "smackfs: Added check catlen"
      smack: recognize ipv4 CIPSO w/o categories

 security/smack/smack.h        | 20 +++++++++++++-------
 security/smack/smack_access.c |  6 ++++--
 security/smack/smack_lsm.c    | 40 ++++++++++++----------------------------
 security/smack/smackfs.c      | 29 ++++++++++++++---------------
 4 files changed, 43 insertions(+), 52 deletions(-)


