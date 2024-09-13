Return-Path: <linux-kernel+bounces-328985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169B8978BBA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88061F260DD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90461714C6;
	Fri, 13 Sep 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rYcLt+65"
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC284A5E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269351; cv=none; b=snL02PQnujbUpDCfQPTm1LLQCFs9cUGe6OCyyPjmyZFC2BNfyoC7RBW4PDTLaFXYZtsui2bw1xPezuwZ5AK4bFqseIydeET8qBhrty+7eeKvEVeyRIw8NPeUjpcKjudzB62x7UnY630KpzPACh7vioO1d+tFdQBQS0pMXqqr39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269351; c=relaxed/simple;
	bh=WLY/q4OQRCsJGzKS77pkbXdUjmJ8GF0xgDggIBghxfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEEef4+g1AKaYvo2neQBPIrZuTsum4/rBQSr4811hkgOW5Wjn2z/BT9PMfWELTpz7C5J4JK826/2oCSfxxlQZ3XAwKxHyapjGJrk75Slj5YQ5RC3XQ6a0lWjEu0TBFUWWOlPyG1aXjVcPJKn/hVvggUB6R/cSODKwgYPrM9BEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rYcLt+65; arc=none smtp.client-ip=66.163.188.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726269348; bh=qkpcDaEMn0agB0sKrkgKSKBb2AUW3d0XoN2fWz60v2M=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rYcLt+658BSIIKHXxR0KDIsJ4MiqUANJOYftANrhLUVjPUGyZnZ/N1AqyFmzMeSY36Wx8O8SV9XS0N0RQWS9dRHwCOCfXhick5NchzJ3QbxAKSgciQx0/rCSzRB5j46lfLQ0NEYfdlQTvnWWh2rbh+11fTae82Xj1dVqcOt/kJg1SLnlyhuHMuOpgTt0fB87ISRb8ooFzM3qajAqrZdkyvFo572Ax3m41RESnsIYU1xxs88196xwVouUaSAP2obI5vMBSj38Yxs8sdnu2xhjl8oG7tyas8H7L7nB1OskDrWAyWFRaxx65W2LE50NQ3Yo9meJhEvqcxIxj95hAwAOrw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726269348; bh=+4vSwHjijdTV7i+LedGZApn+TYWVuMdw1Ewfiz4Hn9s=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WdKLHecTunt9lR3sUijdcLBBR8q7VBrbprbKOzOf/ZouJ5NkPVhlesILZXzK6BsaWiytz6lzbjRUQUSlT+GARTUnuPapalaqKHbzSAVxOpO7OJYmONgMX5t/9YDanrn5pqAk0IvVF6wTfoCjRHLtssJVChJQ2YTLpf/3mK0jAduXrunkBu4dDfkVUuqFbVJjicMvn0doAp2KsQ9Hn36n/5j0NBl2cY0bnug1YGC/FigzNntPjZGJYoayP9SL7jpYktBUy3CbVFFmC57sM9q7nnnqgMa8ZMWo2X9MeizPjrINYVG3HpFshjMW9bvVW5CUU0QBVSNbtyqMMGyhI7WLqQ==
X-YMail-OSG: OpAZDNYVM1m.A9yznG14JY5e5ReNVQLfohi4Yfvq1Hb3I0m1L1_U8y.jg_7Aki3
 3j5AwYak_wl8bXFfvU_eY.tND1Nzff49mJopPskhO2Oc1V8ph.unE.GFlVv2nu2gLhE9XQ_JwYkY
 WXxF9jRRIeT6SMGnjLoL049hR9pgt.3DK2gzPHDm6mQPjHj3tN.hPzsqlsovPTUzBBfW6ob1CVOI
 hwzzt.xbPY.1cmd_6xCFiPN_BAdd0djuCCrTUbhwSTZ8wh_A1WOgy_2HTH4r9TR8oqHl6A8j.RDe
 JRMylCu78.1RQ4bK9bIdus2PMSH9OZNLHJIIjdk4ajSSBPuijZudCrlKqocuyUzmCHFAo6ywBM6z
 cUBRn_MIyqB.NhzLlOiaA_AjqS3YRWy.ai4C2rZ4zJq162s6TBWt9lMwJEVadCT0u5cBIrwbtlfr
 CdSzKr0iVDknRs._U71iSIG4jcYVxYnzrBNs7b4f79__eX9e.uLQCoScAP_ebGlt5Pc7Dhi3oiss
 feeZbi6eP4SiGghyO0KvXbxi6Q8DXGYk1LTVxz4sE7AW6Gy2pBh9zKWeKokh1DzfSqOQGHfrppus
 1W5yEI11GOexJ_5zlrn24iW5_KH28fyyGK23ViQqv_2H51Z0ud_ZNPsgYsrmu3uRPnMH_1RpM__4
 cOQnvOdtwvml8xCqLxwWcSNl9k566_ZRFoo7cXClsFDVt1e220Ia3Snveshao.ugtyvJW0KWmnQK
 gYbyegY.gWm2RENFAQ85JavtxpVkzSs3MWqVZ7BtUU1VmYLHVkVlp6WI9C23fsbGLigvUhkM8fCN
 fsJwXr7jbNiAT.w56fF06nGKfisbDOmlU8qVMnnKhO6ZmikvPK3.YGMc24jIO10hSbFH3sfYsnok
 zjB5_N7Jl4i5buw3mFBzBciFa13llS5sMnleiK3mbnjRva.1tfcgIgpWkNyORBccGklPSX25aJlj
 zJJnOjrRosLEJVao58HJRCQJlO9FseKl6DzQLu5FBw8FoS94fP0vmKjCXwCRmwnWzgf1h9ly5z3m
 JzotXfpnknPxJLcSANnLiH8GIH77vUvPy7WBBHat.fjjZ_BFhGP9w8q2_8GoAU_9peX5saNICvG4
 t2JzAIQHBUWKcpGMoUZEiQeRsRi3GtUjkqanF2SAvrwbkKYsnSg4d565v0UrrdcS6d0Ia9_U8QQb
 BcNf_gyLKhcddK4nSx8j4OnGR8b51SClK7JzqR18e5kpWRUNz1ZbcmkaklarAP2EoqoYywRu_klt
 cNLF4vK50QEtP9JfxUZy3S_wQKDmcj7UtH58IrwxeK3H2IKPxgOY_QAlofewPQM3XYb8DpnvtdVl
 K2Fc6lTHcauU5TZJ_KQmK9bE09M2V3sQdmOEvssSe06QsBzSMERbOte4rMfx4K7c1PL2CcWcIlwX
 UJPH4OkWk8eZT8FCaEJNenPn8rUNtQNsL11cwJIlTJ9VFIjH9QOajoRK8aIygzmUIiWmkR3aim76
 aq7RQhv3wDcPjco9JGEwjU7n3vDC7qE4VyHHOaq_CYosC1HDwgD0NCfp4sg0jbwhMMXMnDJasj8M
 iMx30.6tt9M_i1ABEc21fFmL7l11VvlO207n05OmvDSXtGc7yjH5o5Nu5UfWigghHnmby_K4g7B7
 5fYaqkgBCDY4aIGzPTI9KwJmt8i52D.4t7rKH.3CcKUJjIhSQqkND8govACr8XnRrBJrMSCx1qxK
 tnrydWpM0eCzF3A1jAb_5IwmwklKmWKSfJ8UdenkkvyX0zjBasLXcGuAZpX6N1.Q0wcTNb6k1LBd
 gw9RB4XtpDeUalh4PREKv3AfwNz6m1WHsbJE_u2VOX1.qR0QQZD4qWnXB1BbZZUtPfiOsNzxrdRG
 ZOl1HwyuK4jLc7nbE2NyIfjSvoJqs4ngngqTDMIi9VqTYQWuNDSWOyb4Rg3qhBE03l83AZ0eFhcd
 NknlgvD8EJ5oI5EnNq.AdVl43YnD5SKsuA_RB_QDZCfz14HYxiYpufTkelNvYulCUt.byBp3vLbh
 Nn_v8y0bS.1DNa8b4iqTRaqadu5tD1_j_Rb.O8Ot8NUpWNy2hEkli2vks6MuP74yfDprExpjxZr1
 uBpfR5Hr7d0nTAg5ZhphaSo4pEkrxmq0ZlJi_YfmDF.gBTKgBz3nwKhYyniYEyYGf7OlEpDKyNeu
 A02X0xPrZCbq9vkWgfHdC6wHaUV12F6LVlVNibIkBiaUv7PLyRS3D3GfZZtt7dTLi_682eT7f8WW
 CHts4w2OS4s5KSBmERsA1r26B_bPWtyQosURC0EKGPmXxxw8fiNs7blPTxD2x7o5BTtR37ruGAwx
 8oJaLVXjeFKX_YJM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e273a0d4-66ae-41ca-97fd-098d826e7005
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 13 Sep 2024 23:15:48 +0000
Received: by hermes--production-gq1-5d95dc458-4tw7n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a0ab4237374df0b7c0c96d77aa7f6d2f;
          Fri, 13 Sep 2024 23:05:36 +0000 (UTC)
Message-ID: <d6de966e-ff67-41a4-8a37-1709119be9fd@schaufler-ca.com>
Date: Fri, 13 Sep 2024 16:05:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] LSM: Add the lsm_prop data structure.
To: Konstantin Andreev <andreev@swemel.ru>, paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
 <20240910184125.224651-2-casey@schaufler-ca.com>
 <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/13/2024 1:49 PM, Konstantin Andreev wrote:
> Casey Schaufler, 10 Sep 2024:
>> ...
>> The lsm_prop structure definition is intended to keep the LSM
>> specific information private to the individual security modules.
>> ...
>> index 1390f1efb4f0..1027c802cc8c 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -140,6 +144,22 @@ enum lockdown_reason {
>> +
>> +/*
>> + * Data exported by the security modules
>> + */
>> +struct lsm_prop {
>> +    struct lsm_prop_selinux selinux;
>> +    struct lsm_prop_smack smack;
>> +    struct lsm_prop_apparmor apparmor;
>> +    struct lsm_prop_bpf bpf;
>> +    struct lsm_prop_scaffold scaffold;
>> +};
>
> This design prevents compiling and loading out-of-tree 3rd party LSM,
> am I right?

No more so than the existing implementation. An upstream acceptable
scheme for loading out-of-tree LSMs has much bigger issues to address
than adding an element to struct lsm_prop.

>
> Out-of-tree LSM's were discussed recently at
>
> https://lore.kernel.org/linux-security-module/efb8f264-f80e-43b2-8ea3-fcc9789520ec@I-love.SAKURA.ne.jp/T/
>
> https://lore.kernel.org/linux-security-module/960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp/T/
>
>
> but it looks like a final decision to ban them is not taken yet.

There has never been (to my knowledge) an effort to "ban" out-of-tree
LSMs. There has also not been interest in actively supporting them since
the "L" in LSM changed from "Loadable" to "Linux", with the exception of
Tetsuo Handa, who has been invited to suggest a viable mechanism. There
is currently support for BPF based security implementations, which can
be maintained out-of-tree. We are currently battling with the notion that
the LSM infrastructure is an attack surface. We really don't want to do
anything to increase that exposure.

> -- 
> Konstantin Andreev
>

