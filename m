Return-Path: <linux-kernel+bounces-378856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012909AD65B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F4D1C20BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07A61E7C2C;
	Wed, 23 Oct 2024 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVeWapD6"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91E1E5735
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717717; cv=none; b=A6A/3ySEjm0pshrrVnH6RNIPoktdOb/Wc0s1bCsS7Ll92e8NE6wpJTLjd20bHbkqUZjbUdCBCw0KlaECIdnBOj6S4WhA5TkdAAZ/hdjZHRZ6bIPBBMQpEGdO2I1LFbwTuk8AWFNe5cBQ8P35mX/IjeNrcAjL/K4RPm/0hEvumYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717717; c=relaxed/simple;
	bh=b3nK3xL8CHApXqs5rULzMwhBft2HaDSioPCi+nr2eB4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=UXi5bJKPtDnH5zOv9lzOQkitdUin/Ds7w2r8qIsmHruxsCB7QV8sKqaNQWeIZV4oQv78qKC+oax1eiO2TVOWA6g79WNo/pX7k7/K5ZBQ3K9fXovWlCwbCPmpy+QBcOwrX8Yf9VueBkQE6DPxxa3zzTPbBZArjsH1g8N4EBD9olQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVeWapD6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb58980711so1726441fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729717714; x=1730322514; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3nK3xL8CHApXqs5rULzMwhBft2HaDSioPCi+nr2eB4=;
        b=IVeWapD6dWLupvQWHZkb6ykob5EpSxORHg1q4VqPBfY5P2X/ah8mNQV1AcQM4YzPbR
         2xyi9+W8ZFsMTQVNj7i6QajJGx3Dg2aNiBI6RJnqwWxhZDEe1CCmDI7mKpxvFN9uyiou
         JqwIyAVWYq/fN9eSScGiNHSbiv5PBWbu4DEzvcVOGUkNV5j+c2zdIWkh5GShU9hVwfOO
         skyucXdViSKwzhY6iflYHlfULPF/KPjHsnDbu1l7Iqb19Tw01QNZ4LHqsuO9K09gAadT
         bG508nlWItsDCcs1rkONBmuIFB0X30dYWms0quYSQteLTZBs5rYV+wBu1ql/zhls0BNF
         zKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717714; x=1730322514;
        h=in-reply-to:content-language:from:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b3nK3xL8CHApXqs5rULzMwhBft2HaDSioPCi+nr2eB4=;
        b=HlwFKSR5g0sPwFof2PrvUDrajObeOB0P/YPV9LEv6cHwmuBJ+sprqw/MvwVL0cR2dY
         DNfiJsFoYYiE1Jn4WwYUcPeiBtyGX8QHp+ubZW3Se+NkqVfEKfHEWLdZ0QVEaRdV9ctt
         PmhbqtqYRY3Lp+zzDcRSWHCQYtSyH4tE3k1BFhoMnLLjKVyWOgh4HUmecDzTUmDti00J
         j4/bGFWpBdL66SuiqpnZTaZd1KK95v70yjcX6vZZVT3NJRWeL8aancTqxGOdT2xj5Ukf
         aetGAPaCn9rzd5B6WLYkI0n9HqpFabGIyCpyOV5I2jH/wuisinAy4TntJS4Zb1FEvkI0
         V8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwgVLFHWa7pMGSirQxP3HN9kg/YMLCE+FqDXzd9ThzUPctL6ic8qOHVeObFCWzx2OPRvMTCnAYadoQKI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwufqMsSXhF5n8yLX9pMTVgibn9jeEvl2eKVnfURDVMT25PN2Cw
	RC+843nskDaWLliSQbNNwTwWolhk7h77L8wCvjJuscsO9cTzuE/M
X-Google-Smtp-Source: AGHT+IEvIK/lvfUAdzaNIBSHssBvKA9Niqjkq+4ARgeBI9d7WVUJIyH6n5q0va+eImXlpbcKzDnxKg==
X-Received: by 2002:a2e:bc23:0:b0:2f3:f358:8657 with SMTP id 38308e7fff4ca-2fc9d5f6245mr22097731fa.44.1729717713308;
        Wed, 23 Oct 2024 14:08:33 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5400:7400:ce29:8129:5435:b143? ([2a01:e11:5400:7400:ce29:8129:5435:b143])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c737c4sm4818879a12.96.2024.10.23.14.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 14:08:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ETU8XyqWyoGmYdMfTxyYuL9T"
Message-ID: <f605e8cd-2229-45d0-88c7-3dcae7eaa9e1@gmail.com>
Date: Wed, 23 Oct 2024 23:08:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in
 validate_sb_layout
To: syzbot <syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <671955c2.050a0220.1e4b4d.0095.GAE@google.com>
From: Gianfranco Trad <gianf.trad@gmail.com>
Content-Language: en-US, it
In-Reply-To: <671955c2.050a0220.1e4b4d.0095.GAE@google.com>

This is a multi-part message in MIME format.
--------------ETU8XyqWyoGmYdMfTxyYuL9T
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test
--------------ETU8XyqWyoGmYdMfTxyYuL9T
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-bcachefs-Fix-invalid-shift-in-validate_sb_layout.patch"
Content-Disposition: attachment;
 filename*0="0001-bcachefs-Fix-invalid-shift-in-validate_sb_layout.patch"
Content-Transfer-Encoding: base64

RnJvbSBjNmQ2MjE1ZDY2ZTliZDNkMTBhMTFhOGI5NDAyNDZmZGEwNDk0ZjMwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBHaWFuZnJhbmNvIFRyYWQgPGdpYW5mLnRyYWRAZ21h
aWwuY29tPgpEYXRlOiBXZWQsIDIzIE9jdCAyMDI0IDIzOjAxOjExICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gYmNhY2hlZnM6IEZpeCBpbnZhbGlkIHNoaWZ0IGluIHZhbGlkYXRlX3NiX2xh
eW91dCgpCgpTaWduZWQtb2ZmLWJ5OiBHaWFuZnJhbmNvIFRyYWQgPGdpYW5mLnRyYWRAZ21h
aWwuY29tPgotLS0KIGZzL2JjYWNoZWZzL2VycmNvZGUuaCAgfCAxICsKIGZzL2JjYWNoZWZz
L3N1cGVyLWlvLmMgfCA1ICsrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2ZzL2JjYWNoZWZzL2VycmNvZGUuaCBiL2ZzL2JjYWNoZWZzL2Vy
cmNvZGUuaAppbmRleCA2NDkyNjM1MTZhYjEuLmI2Y2JkNzE2MDAwYiAxMDA2NDQKLS0tIGEv
ZnMvYmNhY2hlZnMvZXJyY29kZS5oCisrKyBiL2ZzL2JjYWNoZWZzL2VycmNvZGUuaApAQCAt
MjIyLDYgKzIyMiw3IEBACiAJeChCQ0hfRVJSX2ludmFsaWRfc2JfbGF5b3V0LAlpbnZhbGlk
X3NiX2xheW91dF90eXBlKQkJCVwKIAl4KEJDSF9FUlJfaW52YWxpZF9zYl9sYXlvdXQsCWlu
dmFsaWRfc2JfbGF5b3V0X25yX3N1cGVyYmxvY2tzKQlcCiAJeChCQ0hfRVJSX2ludmFsaWRf
c2JfbGF5b3V0LAlpbnZhbGlkX3NiX2xheW91dF9zdXBlcmJsb2Nrc19vdmVybGFwKQlcCisJ
eChCQ0hfRVJSX2ludmFsaWRfc2JfbGF5b3V0LCAgICBpbnZhbGlkX3NiX2xheW91dF9zYl9t
YXhfc2l6ZV9iaXRzKSAgICAgXAogCXgoQkNIX0VSUl9pbnZhbGlkX3NiLAkJaW52YWxpZF9z
Yl9tZW1iZXJzX21pc3NpbmcpCQlcCiAJeChCQ0hfRVJSX2ludmFsaWRfc2IsCQlpbnZhbGlk
X3NiX21lbWJlcnMpCQkJXAogCXgoQkNIX0VSUl9pbnZhbGlkX3NiLAkJaW52YWxpZF9zYl9k
aXNrX2dyb3VwcykJCQlcCmRpZmYgLS1naXQgYS9mcy9iY2FjaGVmcy9zdXBlci1pby5jIGIv
ZnMvYmNhY2hlZnMvc3VwZXItaW8uYwppbmRleCBjZTc0MTBkNzIwODkuLjQ0ZDBhYzliMDBk
ZCAxMDA2NDQKLS0tIGEvZnMvYmNhY2hlZnMvc3VwZXItaW8uYworKysgYi9mcy9iY2FjaGVm
cy9zdXBlci1pby5jCkBAIC0yODcsNiArMjg3LDExIEBAIHN0YXRpYyBpbnQgdmFsaWRhdGVf
c2JfbGF5b3V0KHN0cnVjdCBiY2hfc2JfbGF5b3V0ICpsYXlvdXQsIHN0cnVjdCBwcmludGJ1
ZiAqb3V0CiAJCXJldHVybiAtQkNIX0VSUl9pbnZhbGlkX3NiX2xheW91dF9ucl9zdXBlcmJs
b2NrczsKIAl9CiAKKwlpZiAobGF5b3V0LT5zYl9tYXhfc2l6ZV9iaXRzID4gQkNIX1NCX0xB
WU9VVF9TSVpFX0JJVFNfTUFYKSB7CisJCXBydF9wcmludGYob3V0LCAiSW52YWxpZCBzdXBl
cmJsb2NrIGxheW91dDogbWF4X3NpemVfYml0cyB0b28gaGlnaCIpOworICAgICAgICAgICAg
ICAgIHJldHVybiAtQkNIX0VSUl9pbnZhbGlkX3NiX2xheW91dF9zYl9tYXhfc2l6ZV9iaXRz
OworCX0KKwogCW1heF9zZWN0b3JzID0gMSA8PCBsYXlvdXQtPnNiX21heF9zaXplX2JpdHM7
CiAKIAlwcmV2X29mZnNldCA9IGxlNjRfdG9fY3B1KGxheW91dC0+c2Jfb2Zmc2V0WzBdKTsK
LS0gCjIuNDMuMAoK

--------------ETU8XyqWyoGmYdMfTxyYuL9T--

