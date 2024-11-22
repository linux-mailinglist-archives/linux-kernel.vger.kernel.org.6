Return-Path: <linux-kernel+bounces-418706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3208C9D6488
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A74F1608C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339DF1DF24D;
	Fri, 22 Nov 2024 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec1XtyyQ"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658F64A8F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303263; cv=none; b=grZySMKIUe54xBypjEqO9ZFlBWNVB8BmGFtVE3vPVyTT2B2Tr8tNlVWJTuzJkhqYJSjrRMMxcql1O8Ai2AEayaOMgN3t8Ml5MQ2+u0se4bcG3QuYfVqc8t9KL/ofjvaxt8el79iEGWhTawiYybn1Cbk3d5oFfioVZscyP8DbDXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303263; c=relaxed/simple;
	bh=3WPXQ/j86XWSACw4HwROq+kgydc6EoyapfuAVuDsdrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5jpJN15exCx5tHRQIigEyqPzMu7bm1axnJ6jhlw2nNV6TArPdxOhgNKWiQwJEMDLsssUSU7tVlZLxsqaexQsA0tSiaW8n7fzEq1HFKMyLxPugx395PUWzoqm7xKTb/M553aQeHxGAhcv7Es8rT273BwCa0OEN8rWcXScdiEisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec1XtyyQ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ee53b30470so1124237eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732303261; x=1732908061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WiupldtCpIPkO+YVcRZk68GlsEoDJURDOE7gxm1zjeQ=;
        b=Ec1XtyyQ9/47OiRzva+W0j8tptvMF+XG5WoGGvawJWo/MqYoQ6SoMe8UwqSa/QRA7t
         77KjJ37W/GhdlFV5IlTVEWvK4XdMp9UOmzLw/HGAsGz0b/WxEcj4WcXEZMim44HAngwt
         nNbtbWq5wy3r3ot7VFijCh0r8P0CuDvWbv/yui8G9lg2rg+0l7FqInQZflWuXaJcU/zT
         b/3ccWxDXnePY2HOAytYepC99xuJcciX/iIkPxrScw+zpnUTZLZhn64EqoNT34dbLJwR
         XyWGiO707WwUhhxtUX3kIt5AjeyePN0UZ6q3q6eJ3OD59PUdGUXjljsQ0puffoGHwz8q
         JQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732303261; x=1732908061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiupldtCpIPkO+YVcRZk68GlsEoDJURDOE7gxm1zjeQ=;
        b=I98TG1x6+SdrrhkmXKk6bE0+wipQenpYd6rg37wvvz+FYR2+XrlTzidTNuyfYvSIQp
         DJ/X8pwj666djIENQUVAEBvgsaJb/spsdul9Pv0sAsMJSAbctatDP/g5+KcZV/Yfmyc4
         ugde7M3Z1HqrglY2ctbHKdtwj19ZdkRB1oYbq17itHZOOzCFF1dRMOahWiiAWDhTWAp0
         wupc02q17R1ZRApmaBHxqJnhYYnsAgEr9iplkhWqjPtZszfYG6mMht+ixkbivy3peI/b
         y1A1G+dIQ6ho8yY50wNM9D1YTjE4J+iaXlTmT+Uwb0Tn/cbi/cYC9h7JJcDalULG7DML
         S4yQ==
X-Gm-Message-State: AOJu0YwV2nKknHFAsPDRomCkp8qLa8FiIHPNSmCRUX0Tw/bphoNYpmDB
	ytET5VqPMs21u6weNa1tvhnW32CsPo5qIeSp0EOHPE93BeyrQmcD2ZK6CZXDYgteOYIO9gsL2SP
	wB7tRL11aCt7zpznKcUKPu9VFr5XI3TTIprs=
X-Gm-Gg: ASbGncvJJ0jRCBncTRYj8zROmQkSTDgj4l8P7D5Lk5YjGVMJhtndgqXYTJlhRn1l3uB
	nNQy9Fd/AOrdNMy5diaHS0HyhIwzQNg==
X-Google-Smtp-Source: AGHT+IH6jrUlMMz6ZS5NC72k9WkRxkgTOJO9tPsLodj4sI0YbzGt6CPH1ZIDk1kuwmvzBn4VVG5R7Z+GyUaxm/6vtO4=
X-Received: by 2002:a05:6820:811:b0:5ee:ebcb:e6e9 with SMTP id
 006d021491bc7-5f06a9e22a5mr3769940eaf.5.1732303259301; Fri, 22 Nov 2024
 11:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPXz4EO5poAP+8+TVWOzahJMa7Q9NGVs+6RuvV38u=YX_xyV+g@mail.gmail.com>
 <6740d477.050a0220.3c9d61.0198.GAE@google.com>
In-Reply-To: <6740d477.050a0220.3c9d61.0198.GAE@google.com>
From: Nicolas Bretz <bretznic@gmail.com>
Date: Fri, 22 Nov 2024 12:20:48 -0700
Message-ID: <CAPXz4EOBuYqN4tDBuMyZ=z3wivp1cohdLt6TX85aXiFdEHwDog@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
To: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000006a5616062785485d"

--0000000000006a5616062785485d
Content-Type: text/plain; charset="UTF-8"

#syz test

--0000000000006a5616062785485d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-ext4-kernel-BUG-in-ext4_write_inline_data.patch"
Content-Disposition: attachment; 
	filename="0002-ext4-kernel-BUG-in-ext4_write_inline_data.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3t4lr2v0>
X-Attachment-Id: f_m3t4lr2v0

RnJvbSBmNGJhZjI5ZWM3OTQyZTg5ZjAxMDEzM2Q3ZTg0OGJhNjlkN2Y3N2YxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNvbGFzIEJyZXR6IDxicmV0em5pY0BnbWFpbC5jb20+CkRh
dGU6IEZyaSwgMjIgTm92IDIwMjQgMDg6MjM6MzggLTA3MDAKU3ViamVjdDogW1BBVENIXSBleHQ0
OiBrZXJuZWwgQlVHIGluIGV4dDRfd3JpdGVfaW5saW5lX2RhdGEKCmtlcm5lbCBCVUcgYXQgZnMv
ZXh0NC9pbmxpbmUuYzoyMzUhCk9vcHM6IGludmFsaWQgb3Bjb2RlOiAwMDAwIFsjMV0gUFJFRU1Q
VCBTTVAgS0FTQU4gTk9QVEkKClJlcG9ydGVkLWJ5OiBzeXpib3QrZmUyYTI1ZGFlMDJhMjA3NzE3
YTBAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBOaWNvbGFzIEJyZXR6
IDxicmV0em5pY0BnbWFpbC5jb20+Ci0tLQogZnMvZXh0NC9leHQ0LmggICB8IDYgKysrKysrCiBm
cy9leHQ0L2lubGluZS5jIHwgMiArLQogZnMvZXh0NC9pbm9kZS5jICB8IDMgKystCiAzIGZpbGVz
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9m
cy9leHQ0L2V4dDQuaCBiL2ZzL2V4dDQvZXh0NC5oCmluZGV4IDQ0YjBkNDE4MTQzYy4uYjlkMTI4
MjQzMjg2IDEwMDY0NAotLS0gYS9mcy9leHQ0L2V4dDQuaAorKysgYi9mcy9leHQ0L2V4dDQuaApA
QCAtMzU2Miw2ICszNTYyLDEyIEBAIGV4dGVybiBpbnQgZXh0NF9nZXRfbWF4X2lubGluZV9zaXpl
KHN0cnVjdCBpbm9kZSAqaW5vZGUpOwogZXh0ZXJuIGludCBleHQ0X2ZpbmRfaW5saW5lX2RhdGFf
bm9sb2NrKHN0cnVjdCBpbm9kZSAqaW5vZGUpOwogZXh0ZXJuIGludCBleHQ0X2Rlc3Ryb3lfaW5s
aW5lX2RhdGEoaGFuZGxlX3QgKmhhbmRsZSwgc3RydWN0IGlub2RlICppbm9kZSk7CiAKK3N0YXRp
YyBpbmxpbmUgYm9vbCBleHQ0X2lubGluZV9wb3NzaWJsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLAor
CQkJCQlsb2ZmX3QgcG9zLCB1bnNpZ25lZCBpbnQgbGVuKQoreworCXJldHVybiBwb3MgKyBsZW4g
PD0gZXh0NF9nZXRfbWF4X2lubGluZV9zaXplKGlub2RlKTsKK30KKwogaW50IGV4dDRfcmVhZHBh
Z2VfaW5saW5lKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmb2xpbyAqZm9saW8pOwogZXh0
ZXJuIGludCBleHQ0X3RyeV90b193cml0ZV9pbmxpbmVfZGF0YShzdHJ1Y3QgYWRkcmVzc19zcGFj
ZSAqbWFwcGluZywKIAkJCQkJIHN0cnVjdCBpbm9kZSAqaW5vZGUsCmRpZmYgLS1naXQgYS9mcy9l
eHQ0L2lubGluZS5jIGIvZnMvZXh0NC9pbmxpbmUuYwppbmRleCAzNTM2Y2E3ZTRmY2MuLmVjMjVm
MDY2YTJjMiAxMDA2NDQKLS0tIGEvZnMvZXh0NC9pbmxpbmUuYworKysgYi9mcy9leHQ0L2lubGlu
ZS5jCkBAIC02NjgsNyArNjY4LDcgQEAgaW50IGV4dDRfdHJ5X3RvX3dyaXRlX2lubGluZV9kYXRh
KHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLAogCXN0cnVjdCBmb2xpbyAqZm9saW87CiAJ
c3RydWN0IGV4dDRfaWxvYyBpbG9jOwogCi0JaWYgKHBvcyArIGxlbiA+IGV4dDRfZ2V0X21heF9p
bmxpbmVfc2l6ZShpbm9kZSkpCisJaWYgKCFleHQ0X2lubGluZV9wb3NzaWJsZShpbm9kZSwgcG9z
LCBsZW4pKQogCQlnb3RvIGNvbnZlcnQ7CiAKIAlyZXQgPSBleHQ0X2dldF9pbm9kZV9sb2MoaW5v
ZGUsICZpbG9jKTsKZGlmZiAtLWdpdCBhL2ZzL2V4dDQvaW5vZGUuYyBiL2ZzL2V4dDQvaW5vZGUu
YwppbmRleCA1NGJkZDQ4ODRmZTYuLmQ0YzBlMGE0MmI4ZSAxMDA2NDQKLS0tIGEvZnMvZXh0NC9p
bm9kZS5jCisrKyBiL2ZzL2V4dDQvaW5vZGUuYwpAQCAtMzA2MSw3ICszMDYxLDggQEAgc3RhdGlj
IGludCBleHQ0X2RhX3dyaXRlX2VuZChzdHJ1Y3QgZmlsZSAqZmlsZSwKIAogCWlmICh3cml0ZV9t
b2RlICE9IENPTlZFUlRfSU5MSU5FX0RBVEEgJiYKIAkgICAgZXh0NF90ZXN0X2lub2RlX3N0YXRl
KGlub2RlLCBFWFQ0X1NUQVRFX01BWV9JTkxJTkVfREFUQSkgJiYKLQkgICAgZXh0NF9oYXNfaW5s
aW5lX2RhdGEoaW5vZGUpKQorCSAgICBleHQ0X2hhc19pbmxpbmVfZGF0YShpbm9kZSkgJiYKKwkg
ICAgZXh0NF9pbmxpbmVfcG9zc2libGUoaW5vZGUsIHBvcywgbGVuKSkKIAkJcmV0dXJuIGV4dDRf
d3JpdGVfaW5saW5lX2RhdGFfZW5kKGlub2RlLCBwb3MsIGxlbiwgY29waWVkLAogCQkJCQkJICBm
b2xpbyk7CiAKLS0gCjIuMzkuNQoK
--0000000000006a5616062785485d--

