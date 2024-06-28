Return-Path: <linux-kernel+bounces-233271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B9191B515
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CD61F221A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CFB17556;
	Fri, 28 Jun 2024 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJWAYYEN"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B179D1;
	Fri, 28 Jun 2024 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541780; cv=none; b=uCdv/21H8aNZ0ZCHLp4ukA5pqks+eD2O3n3yNDeawgYpmnVYmAO9ZkPBUEFWMCsxmp4MJwqcVImXGY6AQ8HDLddv2GLRvuLQpCVwxbVLnLsRNvwmheC4iR8lNXTfKwTv5riEnvXzq6ogVlPJYSwJk/y3owdJg1k3cvWCKdPxuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541780; c=relaxed/simple;
	bh=HmNiO1dQqRCiY+O0vf0uWKNoxP3ZfrTFCRDGdl8atvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOXdurkwX8mJDmiSLvialCh3XJ7RE6UmPa5HlFnJ2gzgpRpEpoPMbnmTdqVs42bUya+/Gh5QfXdBKltsuvogZ232BtzIj8KlheMM7AvAPi0kZdBysqxlQ5OI6Ercclmf5M1FagFIxENv/QMZ3CcL+T0L0Wp1+GUo2zmk+KMOqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJWAYYEN; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25c9786835eso78874fac.3;
        Thu, 27 Jun 2024 19:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719541778; x=1720146578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmNiO1dQqRCiY+O0vf0uWKNoxP3ZfrTFCRDGdl8atvY=;
        b=hJWAYYENEEH7maDXEk06q/Ty+ePc75jc2TCwmDjoiaad9cos2cifny5aed8cmhzvK1
         Dm6mrxOE5pb+gK/ZK3/+c92m30y/HKTpIcDB3Ut4Oyv1gyMxPohrHLZFUProum0kBhbs
         h85eY8Ya8/RH7m48poCI29Qug/qzrg9JLs10VxX8OkajUAQK+byWn+fOTMZ7JTwXXECp
         OBwXjUNeaMThqYNjnE3A6FyGdbCiT9hVB9yyZvqMNDndqMK6t5gOJyILkgfSzXy4siIv
         B+sIqzTeIOZR/kB5294GmnED3NjpCPBnhXpgtdUtzmU3Njgtmhm33SQwJFn1ROHLDUyK
         2Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541778; x=1720146578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmNiO1dQqRCiY+O0vf0uWKNoxP3ZfrTFCRDGdl8atvY=;
        b=t+6eZg3+Hqv6BwEYIfRAsWPRc8Uh8InltIgQ4GC2fp4qPo8nJH1e+4RQ841U0SzkeH
         iXZLHVMexDg0e1LzkfvxIX28dEn3ZCCJ99H8Ujvg+oYncK78At688hR/Q7AriB21Zf87
         BMvCjNQ9dBTR+njr39St8hT8X/uZIRrYjKqLfakFSLy/UWk7B6zVfVvc+QVhaBTgDodd
         NBy36VgQDTDz66upXNzLU4NQQ3NsLeTJ5OGKWsDjxzVBc7TxGZzmc7ENk4PUJIFhu+Mp
         GCc+g6AfexAYV4s3W585Odvv/vRdWatTEVmB9fC5LgZEo5kKu9jV4rTbbR5Qh1/VAwiF
         nGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYPkQBT3EOGM+K70XmZhnuk9qTKxnFaVlacV4+Rj6bQWlWDYfY1ct8SqycY4jy2WZRrBa8kNXgdCcnrA4l8BGt2KRGuz2NB1/8sv6Zmn1Ig5ldsxAefuIxDoRIFTOIP+jrEZs7owNu
X-Gm-Message-State: AOJu0YwiKNfRp7T5pD33q0hqisOwWVbvX7aLg2jkrHN7xTqLRSGRvjBv
	a/FZMTTaDhbLCsdzA7D7rHGqVSMRnulckfw522TNOvKAlV3kwKL25Ug3R4SlbJdQ1Seb17c/k5O
	6BoJGmFN2feEs8/uAFcK3aRaqWZw=
X-Google-Smtp-Source: AGHT+IF4DRMLrmJp1+Z6QiFMQurojKRJgzxNGRcLIuKm4q+1FcGd3XRYj+gIQEdUWPxTDCZ+rg3SGjx8+L0FK8xIAQ8=
X-Received: by 2002:a05:6870:1643:b0:254:7f9f:3f21 with SMTP id
 586e51a60fabf-25d06c5b75dmr15933297fac.27.1719541777672; Thu, 27 Jun 2024
 19:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628013621.46741-1-wodemia@linux.alibaba.com>
In-Reply-To: <20240628013621.46741-1-wodemia@linux.alibaba.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Fri, 28 Jun 2024 10:29:09 +0800
Message-ID: <CAD-N9QWO2Km2mV0LJntF+RLQYXVfu3mQZ-zcywqhdtYH70yV7g@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst
 translation document
To: Tao Zou <wodemia@linux.alibaba.com>
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBKdW4gMjgsIDIwMjQgYXQgOTozNuKAr0FNIFRhbyBab3UgPHdvZGVtaWFAbGludXgu
YWxpYmFiYS5jb20+IHdyb3RlOg0KPg0KPiBBZGQgdHJhbnNsYXRpb24gemhfQ04vYWRtaW4tZ3Vp
ZGUvbnVtYXN0YXQucnN0IGFuZCBsaW5rIGl0IHRvDQo+IHpoX0NOL2FkbWluLWd1aWRlL2luZGV4
LnJzdCB3aGlsZSBjbGVhbiBpdHMgdG9kbyBlbnRyeS4NCj4NCj4gY29tbWl0IDc3NjkxZWU5MmQ0
YSAoIkRvY3VtZW50YXRpb246IHVwZGF0ZSBudW1hc3RhdCBleHBsYW5hdGlvbiIpDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IFRhbyBab3UgPHdvZGVtaWFAbGludXguYWxpYmFiYS5jb20+DQo+IFJldmll
d2VkLWJ5OiBZYW50ZW5nIFNpIDxzaXlhbnRlbmdAbG9vbmdzb24uY24+DQo+IFJldmlld2VkLWJ5
OiBBbGV4IFNoaSA8YWxleHNAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICAuLi4vdHJhbnNsYXRpb25z
L3poX0NOL2FkbWluLWd1aWRlL2luZGV4LnJzdCAgfCAgMiArLQ0KPiAgLi4uL3poX0NOL2FkbWlu
LWd1aWRlL251bWFzdGF0LnJzdCAgICAgICAgICAgIHwgNDggKysrKysrKysrKysrKysrKysrKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vYWRtaW4t
Z3VpZGUvbnVtYXN0YXQucnN0DQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy96aF9DTi9hZG1pbi1ndWlkZS9pbmRleC5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy96aF9DTi9hZG1pbi1ndWlkZS9pbmRleC5yc3QNCj4gaW5kZXggYWMyOTYwZGEzM2U2
Li4wZGI4MGFiODMwYTAgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25z
L3poX0NOL2FkbWluLWd1aWRlL2luZGV4LnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3RyYW5z
bGF0aW9ucy96aF9DTi9hZG1pbi1ndWlkZS9pbmRleC5yc3QNCj4gQEAgLTY4LDYgKzY4LDcgQEAg
VG9kb2xpc3Q6DQo+ICAgICBjcHUtbG9hZA0KPiAgICAgY3B1dG9wb2xvZ3kNCj4gICAgIGxvY2t1
cC13YXRjaGRvZ3MNCj4gKyAgIG51bWFzdGF0DQo+ICAgICB1bmljb2RlDQo+ICAgICBzeXNycQ0K
PiAgICAgbW0vaW5kZXgNCj4gQEAgLTEwOSw3ICsxMTAsNiBAQCBUb2RvbGlzdDoNCj4gICogICBt
b2R1bGUtc2lnbmluZw0KPiAgKiAgIG1vbm8NCj4gICogICBuYW1lc3BhY2VzL2luZGV4DQo+IC0q
ICAgbnVtYXN0YXQNCj4gICogICBwYXJwb3J0DQo+ICAqICAgcGVyZi1zZWN1cml0eQ0KPiAgKiAg
IHBtL2luZGV4DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9D
Ti9hZG1pbi1ndWlkZS9udW1hc3RhdC5yc3QgYi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96
aF9DTi9hZG1pbi1ndWlkZS9udW1hc3RhdC5yc3QNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
aW5kZXggMDAwMDAwMDAwMDAwLi5jMGY1NGQ5YTZiMDUNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysg
Yi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9hZG1pbi1ndWlkZS9udW1hc3RhdC5y
c3QNCj4gQEAgLTAsMCArMSw0OCBAQA0KPiArLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjANCj4gKy4uIGluY2x1ZGU6OiAuLi9kaXNjbGFpbWVyLXpoX0NOLnJzdA0KPiArDQo+ICs6
T3JpZ2luYWw6IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbnVtYXN0YXQucnN0DQo+ICs6VHJh
bnNsYXRvcjogVGFvIFpvdSA8d29kZW1pYUBsaW51eC5hbGliYWJhLmNvbT4NCj4gKw0KPiArDQo+
ICs9PT09PT09PT09PT09PT09PT09PT09PQ0KPiArTnVtYeetlueVpeWRveS4rS/mnKrlkb3kuK3n
u5/orqENCj4gKz09PT09PT09PT09PT09PT09PT09PT09DQo+ICsNCj4gKy9zeXMvZGV2aWNlcy9z
eXN0ZW0vbm9kZS9ub2RlKi9udW1hc3RhdA0KPiArDQo+ICvmiYDmnInmlbDmja7nmoTljZXkvY3p
g73mmK/pobXpnaLjgILlt6jpobXmnInni6znq4vnmoTorqHmlbDlmajjgIINCj4gKw0KPiArbnVt
YV9oaXTjgIFudW1hX21pc3PlkoxudW1hX2ZvcmVpZ27orqHmlbDlmajlj43lupTkuobov5vnqIvm
mK/lkKbog73lpJ/lnKjku5bku6zlgY/lpb3nmoToioLngrnkuIrliIbphY3lhoXlrZjjgIINCj4g
K+WmguaenOi/m+eoi+aIkOWKn+WcqOWBj+WlveeahOiKgueCueS4iuWIhumFjeWGheWtmOWImeWc
qOWBj+WlveeahOiKgueCueS4iuWinuWKoG51bWFfaGl06K6h5pWw77yM5ZCm5YiZ5Zyo5YGP5aW9
55qE6IqC54K55LiK5aKeDQo+ICvliqBudW1hX2ZvcmVpZ27orqHmlbDlkIzml7blnKjlrp7pmYXl
hoXlrZjliIbphY3nmoToioLngrnkuIrlop7liqBudW1hX21pc3PorqHmlbDjgIINCg0K5Y+N5bqU
IC0+IOWPjeaYoA0KDQpUaGlzIHNob3VsZCBiZSBhIHR5cG8uDQoNCj4gKw0KPiAr6YCa5bi477yM
5YGP5aW955qE6IqC54K55piv6L+b56iL6L+Q6KGM5omA5Zyo55qEQ1BV55qE5pys5Zyw6IqC54K5
77yM5L2G5piv5LiA5Lqb6ZmQ5Yi25Y+v5Lul5pS55Y+Y6L+Z5LiA6KGM5Li677yM5q+U5aaC5YaF
5a2Y562W55Wl77yMDQo+ICvlm6DmraTlkIzmoLfmnInkuKTkuKrln7rkuo5DUFXmnKzlnLDoioLn
grnnmoTorqHmlbDlmajjgIJsb2NhbF9ub2Rl5ZKMbnVtYV9oaXTnsbvkvLzvvIzlvZPlnKhDUFXm
iYDlnKjnmoToioLngrnkuIrliIYNCj4gK+mFjeWGheWtmOaXtuWinuWKoGxvY2FsX25vZGXorqHm
lbDvvIxvdGhlcl9ub2Rl5ZKMbnVtYV9taXNz57G75Ly877yM5b2T5ZyoQ1BV5omA5Zyo6IqC54K5
5LmL5aSW55qE5YW25LuW6IqC54K5DQo+ICvkuIrmiJDlip/liIbphY3lhoXlrZjml7blop7liqBv
dGhlcl9ub2Rl6K6h5pWw44CC6ZyA6KaB5rOo5oSP77yM5rKh5pyJ5ZKMbnVtYV9mb3JlaWdu5a+5
5bqU55qE6K6h5pWw5Zmo44CCDQo+ICsNCj4gK+abtOWkmue7huiKguWGheWuuToNCj4gKw0KPiAr
PT09PT09PT09PT09PT09ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQ0KPiArbnVtYV9oaXQgICAgICAgIOS4gOS4qui/m+eoi+aDs+im
geS7juacrOiKgueCueWIhumFjeWGheWtmOW5tuS4lOaIkOWKn+OAgg0KPiArDQo+ICtudW1hX21p
c3MgICAgICAg5LiA5Liq6L+b56iL5oOz6KaB5LuO5YW25LuW6IqC54K55YiG6YWN5YaF5a2Y5L2G
5piv5pyA57uI5Zyo5pys6IqC54K55a6M5oiQ5YaF5a2Y5YiG6YWN44CCDQo+ICsNCj4gK251bWFf
Zm9yZWlnbiAgICDkuIDkuKrov5vnqIvmg7PopoHlnKjmnKzoioLngrnliIbphY3lhoXlrZjkvYbm
mK/mnIDnu4jlnKjlhbbku5boioLngrnlrozmiJDlhoXlrZjliIbphY3jgIINCj4gKw0KPiArbG9j
YWxfbm9kZSAgICAgIOS4gOS4qui/m+eoi+i/kOihjOWcqOacrOiKgueCueeahENQVeS4iuW5tuS4
lOS7juacrOiKgueCueS4iuiOt+W+l+S6huWGheWtmOOAgg0KPiArDQo+ICtvdGhlcl9ub2RlICAg
ICAg5LiA5Liq6L+b56iL6L+Q6KGM5Zyo5YW25LuW6IqC54K555qEQ1BV5LiK5L2G5piv5Zyo5pys
6IqC54K55LiK6I635b6X5LqG5YaF5a2Y44CCDQo+ICsNCj4gK2ludGVybGVhdmVfaGl0ICDlhoXl
rZjkuqTlj4nliIbphY3nrZbnlaXkuIvmg7PopoHku47mnKzoioLngrnliIbphY3lhoXlrZjlubbk
uJTmiJDlip/jgIINCj4gKz09PT09PT09PT09PT09PSA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gKw0KPiAr5L2g5Y+v5Lul5L2/
55SobnVtYWN0bOi9r+S7tuWMhe+8iGh0dHA6Ly9vc3Muc2dpLmNvbS9wcm9qZWN0cy9saWJudW1h
L++8ieS4reeahG51bWFzdGF05bel5YW3DQo+ICvmnaXovoXliqnpmIXor7vjgILpnIDopoHms6jm
hI/vvIxudW1hc3RhdOW3peWFt+ebruWJjeWPquWcqOacieWwkemHj0NQVeeahOacuuWZqOS4iui/
kOihjOiJr+WlveOAgg0KPiArDQo+ICvpnIDopoHms6jmhI/vvIzlnKjljIXlkKvml6DlhoXlrZjo
ioLngrnvvIjkuIDkuKroioLngrnmnIlDUFVz5L2G5piv5rKh5pyJ5YaF5a2Y77yJ55qE57O757uf
5LitbnVtYV9oaXTjgIFudW1hX21pc3PlkowNCj4gK251bWFfZm9yZWlnbue7n+iuoeaVsOaNruS8
muiiq+S4pemHjeabsuino+OAguWcqOW9k+WJjeeahOWGheaguOWunueOsOS4re+8jOWmguaenOS4
gOS4qui/m+eoi+WBj+WlveS4gOS4quaXoOWGheWtmOiKgueCue+8iOWNsw0KPiAr6L+b56iL5q2j
5Zyo6K+l6IqC54K555qE5LiA5Liq5pys5ZywQ1BV5LiK6L+Q6KGM77yJ77yM5a6e6ZmF5LiK5Lya
5LuO6Led56a75pyA6L+R55qE5pyJ5YaF5a2Y6IqC54K55Lit5oyR6YCJ5LiA5Liq5L2c5Li65YGP
5aW96IqC54K544CCDQo+ICvnu5PmnpzkvJrlr7zoh7Tnm7jlupTnmoTlhoXlrZjliIbphY3kuI3k
vJrlop7liqDml6DlhoXlrZjoioLngrnkuIrnmoRudW1hX2ZvcmVpZ27orqHmlbDlmajvvIzlubbk
uJTkvJrmia3mm7LmnIDov5HoioLngrnkuIrnmoQNCj4gK251bWFfaGl044CBbnVtYV9taXNz5ZKM
bnVtYV9mb3JlaWdu57uf6K6h5pWw5o2u44CCDQo+IC0tDQo+IDIuMzkuMyAoQXBwbGUgR2l0LTE0
NikNCj4NCj4NCg==

