Return-Path: <linux-kernel+bounces-527211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2611DA4087D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845053B372E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5608220AF85;
	Sat, 22 Feb 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="huqtpLq7"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011026.outbound.protection.outlook.com [52.103.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D820766E;
	Sat, 22 Feb 2025 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228869; cv=fail; b=oITGk2f/nfxMtnBm3AadCiv/CFYhvnEYu5tnVB6V9xfWEq/rUHYyMq099TijqLuYxlGLku7Uj+rQ7cXeyqgfpreHb+SQfFQcLcop+lgAb3edqQmTrW3KRknPgVfZvGD5P9QRdeWqUT9PnCilqy/K7/wEeqHOsToLmYYv5A9veec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228869; c=relaxed/simple;
	bh=eIdLKK62RFKfU65szzTCoVwzWG5QdoG6Sg8tfiJow14=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hpMcQdZjbQdIs7qWZ1udcDXs4laND6eHlgkz+tpedOEGfGavMbSVq4In+JS1MSzBNucu5RJUaz9PHv3bknR0m+g4YLh/T6DntdHR0fZjiXaGpKo+Lla38mW8XIkqRrF62i/6LzvInYq8DhWypRupgvW16qbRkwVqto0qTHdvapQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=huqtpLq7; arc=fail smtp.client-ip=52.103.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZP8MUIaYamOIWWslBreq6xIuSUgtGLZ3tljOkdiBreDaYiJsebsi90n3GnXPuaoPqmICjKbrEpHBCGuHZAW3QxoOiVJFFu//pP26bUXB8jEGRD6g2y/cxQ6wQoTfYWZ41uGJPTU64+34S8xAHbblZORXohe0Jde949+Fp1knLCivTQ73Qji9gn7gfBuNh8/OZp22OkBmxowo6xlLz91IK7CA+C8H9/xigvtCj1wv6nhKgy6yd4pX2eQWsOX0a5VuiVeV5NMWSlX5EJCuqRAnshFpLHRC0mieV2a7cIG7KWXiRZU4ksbaRNc9V1K2y+I23IsHiUDe6t2U2SZiqHtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIdLKK62RFKfU65szzTCoVwzWG5QdoG6Sg8tfiJow14=;
 b=VcWCf6a6GF1Siaj5sODOmzsfWJxbQfzXPzf2Qgo9q5tj2m5ssvvBAQg+Z/Nc0xl9MMduo9ycDLahhnkahgECsJ0gukdoleEbQ3rZGtz1pQjcTTDCdb4BFo4PYDEq11QhfTua8Me0CxvH6l3MxVmePwpnyRy+jW8Vl59J5c06q39fCcscwwftWgo70JMm7eRab9YmtUXxV0oO+8lxe87fTlulTioqGvUvtk6uzkHu6w+8JsCqHM1jSBKjWm0magAr53neeUIDpenwwug8P06pp+fpvJQ1FF4d9qJpAQj66aneKYO3bOeFEsIcmqZZNTP+dxQFAbyDZhwAnK2zWA9u7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIdLKK62RFKfU65szzTCoVwzWG5QdoG6Sg8tfiJow14=;
 b=huqtpLq7IwkgXK3xzn9QfWaq9zdWMeQ9/ZUPLr6aRBjWIJQ6SfopsslFb+MI8SUtYrq3/vpx9V5/VObmNnF0nsu8uESH/7mKOdbul77QCXyl6FQYccemyv36aYqgsfrBy65T24oPcAiaGRwwrF5WyAe2xOTuCZ/7XHW2YmLCPudbMckXxt3tKZ6uavE39SpYrYC/t+xZNZteHqFD22JvmBqMoLWtqe88sa8tNTxN4R96deBT4zfpezId8vdIdGdx/wsC0anYHr43n4v4MazR7B08pIITyjqOicEh7bi6Shf8k0lLjRnNiCYhvILcqUwVJwyegve7g+sgl1ODXpEJ3w==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OS9PR01MB15228.jpnprd01.prod.outlook.com (2603:1096:604:3b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sat, 22 Feb
 2025 12:54:23 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 12:54:22 +0000
Message-ID:
 <TYCPR01MB84379C13A329703421086FF298C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Sat, 22 Feb 2025 20:54:17 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: fml13v01: increase eMMC bus speed
To: maud_spierings@hotmail.com, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20250215-fml13v01_emmc_speed-v1-1-e3bd224ae0e8@hotmail.com>
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 xsFNBGK0ObIBEADaNUAWkFrOUODvbPHJ1LsLhn/7yDzaCNWwniDqa4ip1dpBFFazLV3FGBjT
 +9pz25rHIFfsQcNOwJdJqREk9g4LgVfiy0H5hLMg9weF4EwtcbgHbv/q4Ww/W87mQ12nMCvY
 LKOVd/NsMQ3Z7QTO0mhG8VQ1Ntqn6jKQA4o9ERu3F+PFVDJx0HJ92zTBMzMtYsL7k+8ENOF3
 Iq1kmkRqf8FOvMObwwXLrEA/vsQ4bwojSKQIud6/SJv0w2YmqZDIAvDXxK2v22hzJqXaljmO
 BF5fz070O6eoTMhIAJy9ByBipiu3tWLXVtoj6QmFIoblnv0Ou6fJY2YN8Kr21vT1MXxdma1e
 l5WW/qxqrKCSrFzVdtAc7y6QtykC6MwC/P36O876vXfWUxrhHHRlnOxnuM6hz87g1kxu9qdr
 omSrsD0gEmGcUjV7xsNxut1iV+pZDIpveJdd5KJX5QMk3YzQ7ZTyiFD61byJcCZWtpN8pqwB
 +X85sxcr4V76EX85lmuQiwrIcwbvw5YRX1mRj3YZ4tVYCEaT5x+go6+06Zon3PoAjMfS1uo/
 2MxDuvVmdUkTzPvRWERKRATxay28efrE5uNQSaSNBfLKGvvPTlIoeYpRxLk7BN0xi/KZIRpS
 lIf0REc1eg+leq2Hxv7Xk/xGwSi5gGxLa6SzwXV8RRqKnw2u6QARAQABzSFTaGVuZ3l1IFF1
 IDx3aWFnbjIzM0BvdXRsb29rLmNvbT7CwY4EEwEKADgWIQSX5PUVXUNSaGVT2H/jUgzJGSnI
 5wUCYrQ5sgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRDjUgzJGSnI57GwD/9O6kei
 9M3nbb1PsFlDE1J9H27mlnRWzVJ2S3yJ8G1oJo8NSaRO7vcTsYPBYpEL1poDQC5MEGh6FXSi
 OnyyHrg8StmGLksQE9awuTnlnQgvXDQMVtm87r1abBAavP5ru2R9x/Tk63+W/VT2hPekMfHa
 JwFi1KATSI1AhsF3CVoj0yDulz1u0uZlircKdbeEDj+raMO0LA12YxWaWtL/b9XaoAqV9vor
 aKhx+0DsZS5bWoUvs+715BArPBr4hPqKavsBwOWfzWDTKln2qv8d+glWkmk6dgvZFcV/9JEJ
 Q8B7rOUMX614dqgwi1t71TI0Fbaou3nhAnES1i1it/aomDUCLvRwjGU2oarmUISFgvZoGYdB
 9DfVfY3FWKtfDJ9KLUk9k3BFfBZgeAYoLnFZwa3rMyruCojAGTApZtaaLZH/jzQf7FpIGGhD
 YnvGKXS01nLCHuZSOEvURLnWdgYeOtwKW1IIcnWJtB12Ajz2yVu3w4tIchRT3wekMh2c3A3Z
 DeEjszezhFyXgoRpNYDBzNl6vbqhnopixq5Wh/yAj6Ey0YrIUbW9NOhIVCGkP4GyJg756SGz
 yPny0U4lA+EP7PS3O7tE0I3Q5qzDH1AEH2proNlsvjZeG4OZ9XWerI5EoIxrwZcOP9GgprB4
 TrXUR0ScTy1wTKV1Hn+w3VAv6QKtFM7BTQRitDmyARAA0QGaP4NYsHikM9yct02Z/LTMS23F
 j4LK2mKTBoEwtC2qH3HywXpZ8Ii2RG2tIApKrQFs8yGI4pKqXYq+bE1Kf1+U8IxnG8mqUgI8
 aiQQUKyZdG0wQqT1w14aawu7Wr4ZlLsudNRcMnUlmf0r5DucIvVi7z9sC2izaf/aLJrMotIp
 Hz9zu+UJa8Gi3FbFewnpfrnlqF9KRGoQjq6FKcryGb1DbbC6K8OJyMBNMyhFp6qM/pM4L0tP
 VCa2KnLQf5Q19eZ3JLMprIbqKLpkh2z0VhDU/jNheC5CbOQuOuwAlYwhagPSYDV3cVAa4Ltw
 1MkTxVtyyanAxi+za6yKSKTSGGzdCCxiPsvR9if8a7tKhVykk4q2DDi0dSC6luYDXD2+hIof
 YGk6jvTLqVDd6ioFGBE0CgrAZEoT0mK6JXF3lHjnzuyWyCfuu7fzg6oDTgx3jhMQJ2P45zwJ
 7WyIjw1vZ3JeAb+5+D+N+vPblNrF4zRQzRoxpXRdbGbzsBd5BDJ+wyUVG+K5JNJ34AZIfFoD
 IbtRm3xt2tFrl1TxsqkDbACEWeI9H36VhkI3Cm/hbfp2w2zMK3vQGrhNuHybIS/8tJzdP3Ci
 zcOmgc61pDi/B6O2IXpkQpgz+Cv/ZiecDm1terRLkAeX84u8VcI4wdCkN/Od8ZMJOZ2Ff+DB
 bUslCmkAEQEAAcLBdgQYAQoAIBYhBJfk9RVdQ1JoZVPYf+NSDMkZKcjnBQJitDmyAhsMAAoJ
 EONSDMkZKcjnnIcP/1Px3fsgNqOEwVNH7hm0S2+x/N/t3kz50zpKhczHZ8GWbN3PPt4wkQkd
 bF+c7V4uXToN4a17bxGdUnA9qljxt8l3aEqd4jBqLn2OJriu21FSnrZOpxb1EwWwvnVUwrLx
 CuV0CFQJdBlYp2ds64aV8PcBOhQ62y1OAvYpAX1cx5UMcHsNVeqrWU0mDAOgvqB86JFduq+G
 mvbJwmh3dA8GnI2xquWaHIdkk06T55xjfFdabwEyuRmtKtqxTP/u6BzowkV2A/GLxWf1inH5
 M81QgGRI2sao6To7sUt45FS+y2zhwh62excOcSxcYqKzs/OiYEJjWMv9vYRwaqJGEVhbfGFO
 jeBOYr+ZCCeARh+z4ilo1C2wupQT8VPsFiY9DRYgkAPKlbn9OqJvoD7VhvyelJagSNuRayrr
 mnEaZMsoRdS22fneCVWM0xlGSgPCVD0n9+6unTnVbmF/BZsEg5QufQKqlFSomu1i23lRDPK/
 1aPc2IoxcQPh2fomy8spA5ROzOjLpgqL8ksEtQ75cBoF1K5mcC2Xo1GyDmdQvbIZe+8qwvQ3
 z9EDivvFtEByuZEeC5ixn4n/c9UKwlk+lQeQeN+Bk7l8G9phd4dWxnmWXQ/ONR/aLzG+Fguu
 GNZCPpu5dVQH44AXoFjoi9YVscUnWnv8sErY943hM8MUsMQ5D0P2
In-Reply-To: <20250215-fml13v01_emmc_speed-v1-1-e3bd224ae0e8@hotmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xlW2XwvSbcsW4Jb2XuZAUZWF"
X-ClientProxiedBy: TYAPR01CA0240.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::36) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <7a938d72-3de7-47d9-b4b2-69a040bcb839@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|OS9PR01MB15228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd94c9f-f824-40e8-9c62-08dd534006a1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6092099012|12121999004|7092599003|15080799006|8060799006|19110799003|5072599009|461199028|20055399003|4302099013|3412199025|440099028|26115399003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVdtYitaSDFVbkxpaHB2elg3U24yTHVTdFdybEd0MXNRcXpVdnJwcVI0Z3VO?=
 =?utf-8?B?djJ1em1lem80Vnp1RnVyTTBFRFRncTBQa1NZVUJvamZFKzI2SGUxMTJQdnh5?=
 =?utf-8?B?TGRrdkxOazlQd3V0MmJhSE1Ibk9qekRMeTlpVVg2RktzV2piUEN4V1V4Rlc1?=
 =?utf-8?B?NW92WlZ4MVZrM0dncmJFOFZYR01rZlp0cWF0YVdtWHgyOVE2eDFQekFFbFg0?=
 =?utf-8?B?ckpGVE1kVVdzQkhiblV6OUtjUDJ0V3ZlWVNPZTJwTDQzcE5FSWt5NHBCWU0y?=
 =?utf-8?B?N1Ztb2V2dERGZlI1Z0QyV1Q3UXAwM1l5QzgvSnZjbXpNMlN5WTNRSW9wcXBM?=
 =?utf-8?B?bjZvWkxGdkFkSVZxdGdBaWVvNW02d0ZlK1VmdzVZVld2Q1RRcTBiYjZrcktX?=
 =?utf-8?B?dVlhSHc0QUFJdXRoM2dHYm1xWVh1MS9GQlQycHFsZFVacFZnR20rMmIvN0Jp?=
 =?utf-8?B?RXEyM1FQeDZobFEydHRjc0phWEswZ2pzTWh3RjdZOTBIU3FpK09OUDhOaDJl?=
 =?utf-8?B?ZDdpdGVremVyS3VRUlhpQkxEMXFtSjV1aGFBTlRNUS90OGVGWUZ3K1RMZVhQ?=
 =?utf-8?B?MDZFeTdKRkJiWlNrZzdrOVgwT0hnRHVkaFJHb0wreEwvSG05T1dFZG90TnJQ?=
 =?utf-8?B?elFPOEF2Z2VTZWdkWTZoV3VwclIvWmlyd05kQ2xwa3cyU0pvaUVnd3YyYXE5?=
 =?utf-8?B?THVQcmJEZlNUUUhadUUxMm1Ud3hkM09uQnovemovQ1J1WXZDa1lPUmI0dUUr?=
 =?utf-8?B?RzBNRFVqbmhRNGtmTlFvZTJrUjYrYndnSHJlL0c5dEdZdEhtRzRod1ZZR285?=
 =?utf-8?B?czFvazcwRnFzV3F1ZHF2dUZEMlM2SEJEeGhJY2dodmYzNnozK3FLWGZKNTNv?=
 =?utf-8?B?cThkeVZYSGx5Z1p5VzNxdDN5NUljdlhkV05MZ2lNZDhDTkp0RGpJUEI3RTB0?=
 =?utf-8?B?THc0ZDR5V0tiWkhUZkp2N2FmeE1yTEhUK1Bwc254eW93Y1RESllJU0pERVlx?=
 =?utf-8?B?SkgwQkRtaE43ekhGSDg3RFdrN2NTaTBVT1RNd0MrQ1U5b29uSHFoSjc0S014?=
 =?utf-8?B?TXB4MjhqTS9vWWU0MTRGVENPbi9Qa0hxRDJlendhcG9jOHhlOFl4aW93c2tW?=
 =?utf-8?B?RzZLbTNRdHQ4S0tFRkhGVElpR001eGNkWlMrYXVMb21GQkNTL0xmd3A1KzdE?=
 =?utf-8?B?MHhGQ3phRWJtQWpjL1I3blpqRGNjT2xFbnhjVVBHNkJiVWJMdWwwVHBQZjRI?=
 =?utf-8?B?VUw5RmtNRXNvZDdkRGFnRjdaTEpFOUVRL29neGVFTjAwMlZHSERGbUZKajhP?=
 =?utf-8?B?OE5xWERQQXBsWkJSK0JJZ2k4aFFRVHYzcGJxYzZmR2FvV29FTDR0RWN2S0t1?=
 =?utf-8?B?WDhwazVlaTc1eVhMQXNJT1dmSUpoekw5eFNmdmhDYk0xQm5rR3RLSUVWWGtK?=
 =?utf-8?B?QlRmbG00VTJsL09CTHVOS2xRMEFYMEV1WXl4azl2cEd5QWRYcTcrVDZnRXha?=
 =?utf-8?B?QzdMVklqTXh1ZkxJK2E2YTJLbUFjMzF3QlhBd1dWeDFPWjAzOTJnUlBZZGxN?=
 =?utf-8?B?bjgvMTlHMWNWVERuZU1UY2xCTHcxUU9RWDliYmxlSXd5aXFGR1lCKy9pRk5P?=
 =?utf-8?B?eXZsZFpuTXZMa01nbG9BbStlVDk2ZkljQ3RnV20rOVVJS1JMNUpmQmJoOWVD?=
 =?utf-8?B?aGJvbThTU2lydWhySWJMalc0QzI0NzdJQ3hvQWxNTXZmZkFlOC9XMVhqVDF4?=
 =?utf-8?Q?h8IayEz4FfZOMj+ODKrdzMlCV2kGZfnOTlbFnfP?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckdNWko2UTQ4cTdTajR4cGNPRlpnak96K3p0ckJRSUtPVGU4a2ViZ3p5TDhR?=
 =?utf-8?B?K1BnZWo2TUlqdTlrdlQrdkhUOG9hNm9oZExiNUR4LzAxcHk3UUhCMXRoZnRZ?=
 =?utf-8?B?RWJkWmJPTkxZNUZwcjBYREp1eUZtNTh2WEJjbEdDQmFjRzh5UWhBamhXbXgr?=
 =?utf-8?B?ZXFPNm1FQWhHQ3hNaVR0VGJYWlFxK3BtVHAvSlF3WFBBUnFYbWg4eDYyQ054?=
 =?utf-8?B?TE00VHM2YWxUSWVERlpaUnQ4WHJBY1FhMEo1WURKcmJiclpUczdySGhsWkI2?=
 =?utf-8?B?TEdRQkRoMG03WjkyL1czQ2Z6U0VYdW91ZUtmYzZVaWJSWWl5aWQraGg4RDRh?=
 =?utf-8?B?K002MkNVUms0OUdSU1dSM0FUOUpFeXE2Qk1nRExXYWtvRDlGLzU0VThJRG1Z?=
 =?utf-8?B?UFVKNHBra3ExbFdZOWR3L0pZcFQzU2FqNUlMci9GQWhGdjhDWkZxT1QwZkFz?=
 =?utf-8?B?SGVpb1JHM1JTdzRFei9PT0pCbWxKTFRvTlhtTlduejJtS3lleVpTcjdYNFk5?=
 =?utf-8?B?SE5WZW9tWUhtMlhneDJNbG1aMDBkZXNiNE5oaUhORW5oZTBHSU1IdmZOYklJ?=
 =?utf-8?B?WnMzaTJJTEo0N1VMUEJCb0FsVU45a08rZ1ZzbGJ4WUdsNEJvWXZtc0dHdmVh?=
 =?utf-8?B?YkFrT1NiY2ZRdnpPekNkZzdROThJMXo1aFNvM3h5L0VORG91NDFIY2NlRlVL?=
 =?utf-8?B?eTMzR2dPR1p2UURPL1RYZXo4NHdvaS9MSVhxQk9ZSXgraWlCU0drb0lLTFJj?=
 =?utf-8?B?K3VKMTFOYVBtQS9hcy9RTGNFSHZySWtnVmpBQVBwaks2UXBqNWxoS1lYVUVk?=
 =?utf-8?B?NVFyMlY4MUhTNUIvQmZRTFBmUzd3bGN1YndqWTY1V0svUjBnVkROdFhOOHR4?=
 =?utf-8?B?bnNsbTZCcEZGNWFMVkpjN0hyK3JJVDhieXBlKzlha0toUytDWVllWklHU1Iv?=
 =?utf-8?B?YW5HdVRmV3dqV2xnaUJXci9kRW1lc2E3c2xDSlcvWWwvTFh6Vm9qeER6bGYz?=
 =?utf-8?B?Z0lpaUV3RHdsR1VBSFNZYTRiMWdzREpJU3lPY09IV2Z4OVJES1ZLUktMOFRS?=
 =?utf-8?B?c0M0bzF5M3krRG1GRGdXK1R5Yy8yOU9kQW5tU2hHeVA5TWdHRmZsUWgzR01a?=
 =?utf-8?B?Qi9Yem52czQ1MzBFazVpNitETVpqaEphZmNZbm5RNllKU0RPb3hLYnBJNWc4?=
 =?utf-8?B?VTkxZlE2dmFTS3EvS2tKMVJ6K1JoMFgrbEhQWm5DeUVMdEtDeUc2U3RVbkFr?=
 =?utf-8?B?c2poc3UvYXkvT2pxZS8waXhJbG1ZV2hFYUJudnE3QTQzeTE1V0FCODVocXRB?=
 =?utf-8?B?eFpSSlc3Y2pBUjB6TzhsVzhwdklLaGZOTUYyKzZWOWFrRGxCTCtSU1JLOG9E?=
 =?utf-8?B?ZVlNdXdSUFNLTEdUYk9ZUitYRmR3dGxKQ1pzdnZwTHduZlVZRzh5MEJva2U3?=
 =?utf-8?B?ODgwUWFJTEVwZnpWdFRPTndLM0JxY1F4OXlTbDFsbVUrTVA3bGd4c1FHbnBW?=
 =?utf-8?B?M2xKVzR4TklCRFdZRGZGRGZmbDloSThjd3d4dlgxUGxYWThGTFB2Y3M5Y1pz?=
 =?utf-8?B?SlBwMVR3anlzTEl4ck5PL0svUGNRdUR0OC91NzNMNHFOMFhkbCtBN0JMTFdJ?=
 =?utf-8?B?SjhKNloxV2J0WXRWMUF1eE9iNXBBOTVZaGlsdy8ydWdWUnV1dzJHYVlySS9r?=
 =?utf-8?B?UnExVlVLK1JJWi9MRjJlQ2x4Yk9QSXFzZnk0RGRFYTcyRUNxRjBWWCt6NlFJ?=
 =?utf-8?Q?LbHB5X+a/zLzglpmk8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd94c9f-f824-40e8-9c62-08dd534006a1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 12:54:21.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15228

--------------xlW2XwvSbcsW4Jb2XuZAUZWF
Content-Type: multipart/mixed; boundary="------------Bi0nbyC8F02qg5aodHRs00KE";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: maud_spierings@hotmail.com, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: wiagn233@outlook.com, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <7a938d72-3de7-47d9-b4b2-69a040bcb839@outlook.com>
Subject: Re: [PATCH] riscv: dts: starfive: fml13v01: increase eMMC bus speed
References: <20250215-fml13v01_emmc_speed-v1-1-e3bd224ae0e8@hotmail.com>
In-Reply-To: <20250215-fml13v01_emmc_speed-v1-1-e3bd224ae0e8@hotmail.com>

--------------Bi0nbyC8F02qg5aodHRs00KE
Content-Type: multipart/mixed; boundary="------------7l5gr5R9AICTDy5xfQeY3gXt"

--------------7l5gr5R9AICTDy5xfQeY3gXt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNClRoZSBjbG9jayBzcGVlZCBsaW1pdCBoZXJlIHNlZW1zIGJlY2F1c2Ugb2Ygc29t
ZSBjbG9jayBIVyBpc3N1ZXM6DQpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgv
Y29tbWl0L2FmNTcxMTMzZjdhZTAyOGVjOWI1ZmRhYjc4ZjQ4M2FmMTNiZjI4ZDMNCg0KTWF5
YmUgd2UgbmVlZCBzb21lIGFzc2lzdCBmcm9tIFN0YXJmaXZlIGd1eXM/DQoNCkJlc3QgcmVn
YXJkcywNClNoZW5neXUNCg0KDQrlnKggMjAyNS8yLzE1IDE3OjQ2LCBNYXVkIFNwaWVyaW5n
cyB2aWEgQjQgUmVsYXkg5YaZ6YGTOg0KPiBGcm9tOiBNYXVkIFNwaWVyaW5ncyA8bWF1ZF9z
cGllcmluZ3NAaG90bWFpbC5jb20+DQo+IA0KPiBUaGUgYXNzaWduZWQgY2xvY2sgc3BlZWQg
b2YgNTAgTUh6IGlzIGFuZCBtYXgtZnJlcXVlbmN5IG9mIDEwME1IeiBhcmUNCj4gbGltaXR0
aW5nIHRoaXMgaW50ZXJmYWNlIHdoaWNoIGlzIFNESU8gNS4wIGNhcGFibGUuIFNhZGx5IGF0
IDIwME1IeiBpdA0KPiBmYWlscyB0byBtb3VudCBhbiBlTU1DIGRyaXZlLCAxNTBNSHogKHJl
YWxseSAxMzIgTUh6KSBpcyB0aGUgaGlnaGVzdCBpdA0KPiB3YXMgYWJsZSB0byBnZXQuDQo+
IA0KPiBUaGlzIGltcHJvdmVzIHRoZSBzZXEgcmVhZC93cml0ZSBwZXJmb3JtYW5jZSBieSAy
eH4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdWQgU3BpZXJpbmdzIDxtYXVkX3NwaWVyaW5n
c0Bob3RtYWlsLmNvbT4NCj4gLS0tDQo+IEkgcHV0IHRoaXMgaW4gdGhpcyBzcGVjaWZpYyBk
dHMgaW5zdGVhZCBvZiB0aGUgY29tbW9uIG9uZSBhcyBJIGNhbm5vdA0KPiB0ZXN0IGlmIG90
aGVyIGJvYXJkcyBhcmUgYWxzbyBhYmxlIHRvIGhhbmRsZSB0aGVzZSBzcGVlZHMuDQo+IA0K
PiBUaGlzIHBhdGNoIGRlcGVuZHMgb24gWzFdDQo+IA0KPiBbMV06IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI1MDIwNzA5MzYxOC4xMjY2MzYtMS1zYW5kaWUuY2FvQGRlZXBj
b21wdXRpbmcuaW8vDQo+IC0tLQ0KPiAgIGFyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUv
amg3MTEwLWRlZXBjb21wdXRpbmctZm1sMTN2MDEuZHRzIHwgNSArKysrKw0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21t
aXQ6IDBiYzA4ZWMxZmY1YTMyNDQ5ZDJiMDQ3MDQxNzNkYmYzZWJkNmIwMTQNCj4gY2hhbmdl
LWlkOiAyMDI1MDIxNS1mbWwxM3YwMV9lbW1jX3NwZWVkLTY3ODEyYmQ5YjQwNA0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMv
c3RhcmZpdmUvamg3MTEwLWRlZXBjb21wdXRpbmctZm1sMTN2MDEuZHRzIGIvYXJjaC9yaXNj
di9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtZGVlcGNvbXB1dGluZy1mbWwxM3YwMS5kdHMN
Cj4gaW5kZXggOGQ5Y2U4YjY5YTcxYmU3OGNhNTc2MThhZTg0MmM5ZjQxNTY0ODQ1MC4uMWY0
YmFjOWY4OTQ2M2E2YWY4NDRiOGYxNzQzYmRmYTY1OWU2MTJhYiAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtZGVlcGNvbXB1dGluZy1mbWwx
M3YwMS5kdHMNCj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAt
ZGVlcGNvbXB1dGluZy1mbWwxM3YwMS5kdHMNCj4gQEAgLTExLDYgKzExLDExIEBAIC8gew0K
PiAgIAljb21wYXRpYmxlID0gImRlZXBjb21wdXRpbmcsZm1sMTN2MDEiLCAic3RhcmZpdmUs
amg3MTEwIjsNCj4gICB9Ow0KPiAgIA0KPiArJm1tYzAgew0KPiArCW1heC1mcmVxdWVuY3kg
PSA8MjAwMDAwMDAwPjsNCj4gKwlhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwxNTAwMDAwMDA+
Ow0KPiArfTsNCj4gKw0KPiAgICZwY2llMSB7DQo+ICAgCXBlcnN0LWdwaW9zID0gPCZzeXNn
cGlvIDIxIEdQSU9fQUNUSVZFX0xPVz47DQo+ICAgCXBoeXMgPSA8JnBjaWVwaHkxPjsNCg0K

--------------7l5gr5R9AICTDy5xfQeY3gXt
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
scUnWnv8sErY943hM8MUsMQ5D0P2
=3DUrys
-----END PGP PUBLIC KEY BLOCK-----

--------------7l5gr5R9AICTDy5xfQeY3gXt--

--------------Bi0nbyC8F02qg5aodHRs00KE--

--------------xlW2XwvSbcsW4Jb2XuZAUZWF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAme5yPoFAwAAAAAACgkQX75KBAfJsRll
+hAAnkM8CXwApJDRzVyY6gMgtAdyK5BjQXceHzKDdbZPyHh36/F2HvxDQwtXueKYzNtytdgHZwf/
vpyrAgDQFaZVWSfARoN2BOtBzZesG0j3o0NZQkCwfuTzS0Dr7CD03muG5WQWtnXyI6emAAfcxnIf
+r/MDMOljfj/vKVQtkoJZhGkUjEwIH2RUy5x/pGYOpAg7aMaYqG/6i5q5+aVNxhNQrCShauamMF6
VMSEeXd/dJHBpS8KMOH7ge1REtvc8F9gqxKj1uQCSFnBBqlemiHq4dQW4NrCQ2IoLaXrItosEyMT
m36Fw05NjlCRcCxbqA3/P/L2XSIQSYtHI7Wc6ThQ4gnlBlkU7XDl8DEpsMIlQhzmX/t/0U1qteo3
cZY74wsHhDs2eTatmMYV/GMVZKfNsdAyFhXLZZlhKe/CeiW6nY5t9+kGi5psgcyMl+0/1TBa+WQd
v8GnL+eksOhQBeO75kKECHAJRvOJXARa5qkykoEZ7IqiYxDNpPVqntToXv8wcOtWCrHfWk05JwAQ
2Aw7RK8JsDChDk792TCCy66JXIsf8fQHxJEadOKYwebjVTsJDWlqb/5/BOr5n3Ore8J7L/1LWHt+
2ccC0T8FB3gf8XdZb/zsa8UW+NxM5/tycLd8hlCAdsJCmrStuqDRSvxSeb8wZxj3zYKVwlIsng8o
6Cc=
=nTqq
-----END PGP SIGNATURE-----

--------------xlW2XwvSbcsW4Jb2XuZAUZWF--

