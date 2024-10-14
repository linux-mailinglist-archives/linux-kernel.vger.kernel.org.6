Return-Path: <linux-kernel+bounces-364800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A51D99D99A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDBE282C53
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7CA1D1E79;
	Mon, 14 Oct 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="O6u/D5JM"
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0813BC02
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943479; cv=none; b=tGNLiPn3tIc3YWMTLwaMYiCSMrucEBWmd++kElVxPwx8DA4ayKmCYLJCLMZscUL4NKGN6tma+lx7qoaINjkbZ+hzRf9K9/RDsrjXu+urAR+xQzRY0+6UKc2IXgosZvhs70QcS4H62jWDGaMevmIOAKSkGKNYooyyi98Dzzv9/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943479; c=relaxed/simple;
	bh=apKGEXU0vRXbU6g7jdQJdMnRukrdAOAYeQyEp3ogTR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRWh1fuD1X6oKVmt1avtqdxJpaDEOBttGHW4kREkz/k/wsLiF09gT1qqQ84kqn94MKm/UbTGNHz9Ofp/FON7cpQgPCDbyFaDz1FTJjPoiqnEq4LHEbZ2oJxID7RL0qcqzeF9J0EJJtfsWRLghuGhRe8a4OxGC72aU5YfBPE3lGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=O6u/D5JM; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728943476; bh=tpFC+3e2BgWO13faeByk9G1Msjge7aBo6uI8U3GBV/g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=O6u/D5JMjhHeubLpZgsUAym/G9jEKRTXGgl3ZdSUO/xsyGg2RCfy0+n3nWRO4gHgoF/1ptAzLooXveGlfODY52nNnwpfAPirP/1cOkdOFSpORdyIyH8EcEh5kWZwCF3vqDCGVYJ55EUeOQ5lei+FVAY1vhpLcOA2Xb7w0e+TOYsW+doI3Lj4lY4VW6L+kk3hPLIVZc5JEiTtaAvGMzpRaXp+9JcbpM4f2v+bl6jjzVvAfqopODrKMKHhuXsbOhCBNBn58Cth3eza6/aTBX2p03Qs3sNQrNhovttOfzwRxoKZFqiBKaqZLpUv8T6Tsl4QFh78hGx2kY4Nv8nOTwNRXw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728943476; bh=8SnpdYO2ltZ+eCt0x3tAkobonTJVyFYksgisaeeCink=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=N0V0a1ia2VuwAfXgbwCzEKY/lBas15SAKDDl5qNS+WyQchI89ZcUmnpptYsWD9aQMFLvZI6BK9n5Bl/TSSZKr16p9hxKV9KyZ36Mh9nEYxIdeCTOS4Wxe1lRr64fYKfy+EO0JorLW5n3P1eZT4IMEfzH8HWV25Qd+uqwcBIzfZU5QL3GrmFf+ewiM6UtDKP6h6mwesejkVlP4d8jeG0ifCI1gmPEwOifpMRaXyu7RsJu7z6cHKg0n09bw9kDSX95xy9xLzPf1vsvnp29u5AdboNv4lw0WDF8WjBRE7oZiRhqIeymIkdlwuN6OseAMVQrvARrnLBTneHIHVbwH5PLmg==
X-YMail-OSG: 4MetJaQVM1lYW17EhBUuB1CIRH8gtUrgiDRU0pJKVkB7F0ZLfZMkjuETyZMcIT4
 saVkien1MR4Dg5mZ9EBwuxsDvH99k8nKl1ccYGz_KWUC8bniX8H44zbczsRGXv5ABzfhiyK8n1DU
 ZrdA_7obazIHYjp5otGM_2JKHJQ0qHdcmIf4sGeVN4xFpua5GM.fe84vfpB82yW.t_EQNEXn3kyr
 phssNqrtnnP2xhhm.LneJmeCXPG6UNWY5tE0zt2I9usVpAiVgyUZFZvg_aZnJhecgCszqYGr2Ysb
 7wHdiA0K9cUcoGLz9eDM9foiYFkPHQgV_vTdSWXQLV3K86yPqFBivuZLYr1txfXRdm2YIpgvTjab
 XHMT738irguDqKasjcFLNGL9Lr6Bz9X6WWHktGIhAd6aOUrsSCGg.6XQZ4y_QR5yQSStynBuXUfO
 NRPbKDyJLMsRAQKvFqpRrtt.cmQOUZg.WU7SeKBpUHfZWMZ2CGXs.Tm.Nl13WCcOuKnabzxqJp2G
 ai6CCDJhmbSdrdLl7iIN6RskFzTjr4QXMAwKUWSttXM_8gU9SNM.UyQy3yAyEPvhM6xXny_apADh
 lCGIKMAS7KW5Ute_uzj.JBZTTOQl2LB0sCVTmSUNNrblaaf8aavb_uHnbfVcjhI9JRQkpQ4aETZ4
 kgKbJr3RDYrm.9ZB7rWQCbx_PWkOLjryseWI571CvPnGNDAX56kBwiS2iVhOhsaR3bfwccKltYsE
 P1dhkm1ivLT8gduzzVZHbM1xTuMY.oFCVbeEi6m8wWXDEKorWPBQ_uIyLMWwXf4lyOFTcJL8tm7D
 AFgWlF6VDf5yaOmsIja0a0.O.3UQZhFpmokIel7Az_YHEfCXE4jStMTNnYTkaUtemQvFWodMgTh2
 Ho6zyMpwYd0zeeubJmt4DdIep4HC3JrtdSGM4le8M.laumjcgQcxBingDfLiuNMAVX4Kp4yQDn80
 IRNITcNWdeYPuMxXSyvU8gKDJKlIVQgqPxcJhDCDpv7B2DPGJFlPbeVc2p._1.AFQ8F05busqNrC
 yCz.nkMIQMYmV1YWRRcnkr3SNLnvD7PpIMkHPRm7RSg31G8_M7aZEcV1tctSZIlZQTF_uBL29Hew
 0BRJZu1KmaPSt2E5j.jEUuT_rpy3dk57Z1G3OTTHtTOfVY.SA8IXXitzTeD4iRGBMEznxT.LBbd4
 3t37WALETQ1kOkw3CmimY3AWXxS_t2dK929HjHTc7w8xGdF.AZ.c2Y88pibGhpykyPkHn_lvBbr2
 1fSoAvnmD2R1v9tISyDSTA09Qs.K_kmPKudiInkTs1gb4Og58X82mB5vlAhxFr_GGyUiN9M7Li.P
 YFINPcN0wbhxvw.Ncb41zE0twkaE1eDk_xhIdwcVrvL1xv1rkB20WUfrjTXDOMzcqROHbbAzeNfX
 blCHz_lh0ObyDeQ8Y_AIQ3Xf4LdrB19vFbfml.BB_GxZYq1m3RYkKwM3lZA25H5RVoGyKALra_X.
 PTTpt_y0zQXKmFp4M8wJzBVipP6iuLNI5B1O.Ki8aXjjBotukTH48Ct9i1P5wzE0eHzlzEO2Ui5F
 JCc18CR_TZFpJdHoqVqev2fCNaJVgWnPo9vPmKvlp5_ckFB.ABhn5Y28ZoWfj1Vpi7FqC2YEH63m
 x3wBLrqxxu.BmCySF_MUcC8HasqtGDAYMGgRbCB7lgQeViod3CnFjGOqbPdA5_ZRJdycf9L29dwI
 F.4XX6ItnLvNu_hF0yqhGEgbzk7OAmjUKTsFiG2GrAkUlaXlt_R9MtVU0jYuNjuMHt2Zkghe9wrM
 yd_tfDj.gJxGyRujpLM_NYK66zIbfrG09CnBET4a_wLud_1GAQbxalVYVM1f9tkHaCR49e8jeosa
 A1WMoUoNHIzCftGa48DbkVsQOs41ir8UoEeE3hEYZZQt12F1nKOB1qUc18aqn9zLaYBCY05wDdpx
 pyZRzFiv1tWbclkQjjKYh_nv6h0fyTGITok5A_lquvIf.wEpnqzYNeQftOz.qCXLGn_MQOBxZSUh
 3laNylFYYgOzKFp5QW62iM30avrrP2SxcBKOgSSNV63mmNKM8sIdIbDRAELPOHdddzN.Km8t5Y57
 vTFVtfrpfqJny.59V.l7X6gbvXePCM_bITkWA7HmPWywEqVB.SpHcfcwTcnnpiFJyBDqth592MTu
 cwb3z_iSbC.M9Vgb5W0WR0zsi8I3gpgiNUhyAZB4XHVW0JPY_v9rIUhZfaZIyBBvotJW9LoHFuEa
 eEYRJjcl5w7sSUs4Abi.fN0sWcDAkQZCURMbzv0IAoaLBrz2qGaWTMxHZfSj0vNCkCH1A_0W_Eq9
 LxmE54g428gF9pfqiHQ1lH._IZrO1tfYJPfY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a37fc936-bb74-4934-b98a-87094d092ab8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 14 Oct 2024 22:04:36 +0000
Received: by hermes--production-gq1-5dd4b47f46-prs6p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8cd769ecc3402b59fcfb097dfca91800;
          Mon, 14 Oct 2024 21:54:26 +0000 (UTC)
Message-ID: <88bc4a97-562d-4cb2-ac12-a7549cb20583@schaufler-ca.com>
Date: Mon, 14 Oct 2024 14:54:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] LSM: Replace secctx/len pairs with lsm_context
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org,
 jmorris@namei.org, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241014151450.73674-1-casey.ref@schaufler-ca.com>
 <20241014151450.73674-1-casey@schaufler-ca.com>
 <20241014212937.GA1100381@mail.hallyn.com>
 <20241014213534.GB1100381@mail.hallyn.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241014213534.GB1100381@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/14/2024 2:35 PM, Serge E. Hallyn wrote:
> On Mon, Oct 14, 2024 at 04:29:37PM -0500, Serge E. Hallyn wrote:
>> On Mon, Oct 14, 2024 at 08:14:44AM -0700, Casey Schaufler wrote:
>>> LSM: Replace secctx/len pairs with lsm_context
>>>
>>> Several of the Linux Security Module (LSM) interfaces use a pair of
>>> pointers for transmitting security context data and data length. The
>>> data passed is refered to as a security context.  While all existing
>>> modules provide nul terminated strings, there is no requirement that
>>> they to so. Hence, the length is necessary.
>>>
>>> Security contexts are provided by a number of interfaces. The interface
>>> security_release_secctx() is used when the caller is finished with the
>>> data. Each of the security modules that provide security contexts manages
>>> them differently. This was safe in the past, because only one security
>>> module that provides security contexts is allowed to be active. To allow
>>> multiple active modules that use security contexts it is necessary to
>>> identify which security module created a security context. Adding a third
>>> pointer to the interfaces for the LSM identification is not appealing.
>>>
>>> A new structure, lsm_context, is created for use in these interfaces.
>>> It includes three members: the data pointer, the data length and
>>> the LSM ID of its creator. The interfaces that create contexts and
>>> security_release_secctx() now use a pointer to an lsm_context instead
>>> of a pointer pair.
>>>
>>> The changes are mostly mechanical, and some scaffolding is used within
>>> the patch set to allow for smaller individual patches.
>> Hey Casey,
>>
>> so this set is not bisectable.  Applying just patch 1 will no compile, right?
>> What is your plan for getting past that?  Squash some or all of them into one?
>> Or are you planning a wider reorg of the patches down the line, once the
>> basics of the end result are agreed upon?
> Sorry, I may have misread that.  secids make my eyes glaze over.

They make my skin crawl, and have since I first saw them circa 1986.
I would love to eradicate them, but they're like bad tattoos, showing
up in embarrassing places for which removal would be too painful.


