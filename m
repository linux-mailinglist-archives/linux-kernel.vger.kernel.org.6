Return-Path: <linux-kernel+bounces-273265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB49466A3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 03:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD3A1F21FEF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5BB4C7C;
	Sat,  3 Aug 2024 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AITOgs9b"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0CC8DF
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722647980; cv=none; b=RJBPhe6jqrNhh42qwiJhhACltDwqoXD5gpVEXlgAgqnk9QCM0Yf6vsxUhWsrEana2pT74RWd02wiyL4oD9f0b2jqlYbNfItxuwFrVzgY2n9SC1fc6rps1qAGMbR+inc2fMlVhPFXAJUOlGUFdBR06989TL9jMFkIxPPwXvjNTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722647980; c=relaxed/simple;
	bh=JO7xGrBaQsl8NED9ZO7C8Gm5gpFYuB58M6cfW8YTUY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vo4VU1g9Jo/QUFjSoHN5lRbYpP2yDGnr065RXqjf9SW1VLbs5xGQIhZV7Op34NKvGGOjsbgpBivUPGH2Tbh3o24EcVfIZh38+9M65afqOSUlV8Ki9ipRtBAioCtHQSBgyL780LCXyy1deaohXnrPlSgky6yDyDY8nbfXr14lXzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AITOgs9b; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso13304221a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 18:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722647976; x=1723252776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CkYn/c61otLNdM1/trydtglQWl8qUqVO0szhKJmLd4U=;
        b=AITOgs9bVPEfYOMIFE9TC56bN392EcfYfeJjBlBHVQ4KRkJHOEHAkcsg6U8f8V0UMA
         8tr2v88dSduL22g3jC1DXRfeTrx7BfvxzMyKLZtMd3pCZzc9kR0O4y6MNVcRCyPilxg4
         zXA8SWiXHya5V91INxLdBVtMrajIOqRClrZ1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722647976; x=1723252776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkYn/c61otLNdM1/trydtglQWl8qUqVO0szhKJmLd4U=;
        b=VNnfTS6KI+R59QOf+a9/uw5jBRuUc2A4s9/cyss5oaiCJwGGBd0F3PZlSt6BPV1/T/
         CZv9sDFBizfBb/Siwh3m9x78/kyiosPENcQj0msvx3qiB1K2EuShZRLJnL45kFL9i9qB
         oEV4WZ1cqaPh5Gf91n/BpKriDpAw8ew5UII0rQgQIrdD/BIqMCO7gq9+GCpPt2ytdaAN
         zQbke7+5T9PEuym77sKLkxvYKKCmx+6H82G3F05DSn5uoZQHAn9tTy5/xYtP7njEmvEE
         PtYlGDAYFbMVF/k5ST/OENaV5Syq98XJCj8xI8cdnw2FX5Od2tpsoq5SXuH9ERHAi4Nj
         Bx1w==
X-Gm-Message-State: AOJu0YyL3/IoDEKghSSwMcvptdu3P4AUxdpMrupCm4pddmWN0o+pIt1R
	1qhHL1mOPEwLrfgBluKFNWQk7HFDeBECYN2UmT8gg4x6duUNtsWcrdg3R/NvBLrBsuoomVinFis
	c8OI=
X-Google-Smtp-Source: AGHT+IEFW60UY1iqFRcB+YomktVQdpVMNucE7JIlIdVnrICyKimLki67wU0wdUEtVAdmdvWa9OG5Ig==
X-Received: by 2002:a05:6402:1a42:b0:59e:9e8b:f6d with SMTP id 4fb4d7f45d1cf-5b7f36f7cd8mr3478431a12.2.1722647975692;
        Fri, 02 Aug 2024 18:19:35 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b82c1f0sm1728647a12.78.2024.08.02.18.19.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 18:19:34 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9e25008aso1153309466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 18:19:34 -0700 (PDT)
X-Received: by 2002:a17:907:7ea8:b0:a7a:83f8:cfd2 with SMTP id
 a640c23a62f3a-a7dc4de30e9mr354120366b.17.1722647973933; Fri, 02 Aug 2024
 18:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802114518.GA20924@redhat.com> <CAHk-=wguPQZKfWdNjF8OedfttMNkrW57Kb5Wjv0NmTzoEbUG7A@mail.gmail.com>
 <20240802221014.GA20135@redhat.com>
In-Reply-To: <20240802221014.GA20135@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Aug 2024 18:19:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXK4cc8ikqN15vfi2+wsYJYh08qH8qzCpy+08Gh9whLw@mail.gmail.com>
Message-ID: <CAHk-=wiXK4cc8ikqN15vfi2+wsYJYh08qH8qzCpy+08Gh9whLw@mail.gmail.com>
Subject: Re: build failure caused by RUNTIME_CONST()
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008f8e3b061ebd3c5d"

--0000000000008f8e3b061ebd3c5d
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Aug 2024 at 15:10, Oleg Nesterov <oleg@redhat.com> wrote:
>
>         $ ld -v
>         GNU ld version 2.25-17.fc23

Yeah, we document that we support building with ld-2.25.  And I went
and looked into the binutils-gdb repo, and it looks like this whole
automatic start/stop symbol thing was introduced in 2.29.

> I can try to polish my hack, but as I said I don't understand this magic,
> and I can only test the build on x86.

Your hack doesn't look horrific to me - or at least no more horrific
than lds files always look.

I ended up with a slightly different approach, only because I'm
(probably entirely in vain) hoping that we might aim to use this
"standard" format of start/stop symbols, so I introduced it as some
kind of simple "NAMED_SECTION()" macro instead.

So this patch seems to work for me, and looks somewhat reasonable (if
people actually start using this and want to use different alignments,
we might have to make that alignment an argument in the future, but
let's go for a really simple macro interface for now).

Does it build and work for you with your old linker too?

                  Linus

--0000000000008f8e3b061ebd3c5d
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-runtime-constants-deal-with-old-decrepit-linkers.patch"
Content-Disposition: attachment; 
	filename="0001-runtime-constants-deal-with-old-decrepit-linkers.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lzdg3xa90>
X-Attachment-Id: f_lzdg3xa90

RnJvbSBlYjRhZDA4ZDkzNWI1MDgxZjRjOTk4NTQzNjIzZmFiZmQyMTYyZTA3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IEZyaSwgMiBBdWcgMjAyNCAxODoxMjowNiAtMDcwMApTdWJqZWN0OiBb
UEFUQ0hdIHJ1bnRpbWUgY29uc3RhbnRzOiBkZWFsIHdpdGggb2xkIGRlY3JlcGl0IGxpbmtlcnMK
TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04
CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClRoZSBydW50aW1lIGNvbnN0YW50cyBs
aW5rZXIgc2NyaXB0IGRlcGVuZGVkIG9uIGRvY3VtZW50ZWQgbGlua2VyCmJlaGF2aW9yIFsxXToK
CiAiSWYgYW4gb3V0cHV0IHNlY3Rpb27igJlzIG5hbWUgaXMgdGhlIHNhbWUgYXMgdGhlIGlucHV0
IHNlY3Rpb27igJlzIG5hbWUKICBhbmQgaXMgcmVwcmVzZW50YWJsZSBhcyBhIEMgaWRlbnRpZmll
ciwgdGhlbiB0aGUgbGlua2VyIHdpbGwKICBhdXRvbWF0aWNhbGx5IFBST1ZJREUgdHdvIHN5bWJv
bHM6IF9fc3RhcnRfU0VDTkFNRSBhbmQgX19zdG9wX1NFQ05BTUUsCiAgd2hlcmUgU0VDTkFNRSBp
cyB0aGUgbmFtZSBvZiB0aGUgc2VjdGlvbi4gVGhlc2UgaW5kaWNhdGUgdGhlIHN0YXJ0CiAgYWRk
cmVzcyBhbmQgZW5kIGFkZHJlc3Mgb2YgdGhlIG91dHB1dCBzZWN0aW9uIHJlc3BlY3RpdmVseSIK
CnRvIGp1c3QgYXV0b21hdGljYWxseSBkZWZpbmUgdGhlIHN5bWJvbCBuYW1lcyBmb3IgdGhlIGJv
dW5kcyBvZiB0aGUKcnVudGltZSBjb25zdGFudCBhcnJheXMuCgpJdCB0dXJucyBvdXQgdGhhdCB0
aGlzIGlzbid0IGFjdHVhbGx5IHNvbWV0aGluZyB3ZSBjYW4gcmVseSBvbiwgd2l0aCBvbGQKbGlu
a2VycyBub3QgZ2VuZXJhdGluZyB0aGVzZSBhdXRvbWF0aWMgc3ltYm9scy4gIEl0IGxvb2tzIHRv
IGhhdmUgYmVlbgppbnRyb2R1Y2VkIGluIGJpbnV0aWxzLTIuMjkgYmFjayBpbiAyMDE3LCBhbmQg
d2Ugc3RpbGwgc3VwcG9ydCBidWlsZGluZwp3aXRoIHZlcnNpb25zIGFsbCB0aGUgd2F5IGJhY2sg
dG8gYmludXRpbHMtMi4yNSAoZnJvbSAyMDE1KS4KCkFuZCB5ZXMsIE9sZWcgYWN0dWFsbHkgc2Vl
bXMgdG8gYmUgdXNpbmcgc3VjaCBhbmNpZW50IHZlcnNpb25zIG9mCmJpbnV0aWxzLgoKU28gaW5z
dGVhZCBvZiBkZXBlbmRpbmcgb24gdGhlIGltcGxpY2l0IHN5bWJvbHMgZnJvbSAic2VjdGlvbiBu
YW1lcwptYXRjaCBhbmQgYXJlIHJlcHJlc2VudGFibGUgQyBpZGVudGlmaWVycyIsIGp1c3QgZG8g
dGhpcyBhbGwgbWFudWFsbHkuCkl0J3Mgbm90IGxpa2UgaXQgY2F1c2VzIHVzIGFueSBleHRyYSBw
YWluLCB3ZSBhbHJlYWR5IGhhdmUgdG8gZG8gdGhhdApmb3IgYWxsIHRoZSBvdGhlciBzZWN0aW9u
cyB0aGF0IHdlIHVzZSB0aGF0IG9mdGVuIGhhdmUgc3BlY2lhbApjaGFyYWN0ZXJzIGluIHRoZW0u
CgpSZXBvcnRlZC1ieTogT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRoYXQuY29tPgpMaW5rOiBodHRw
czovL3NvdXJjZXdhcmUub3JnL2JpbnV0aWxzL2RvY3MvbGQvSW5wdXQtU2VjdGlvbi1FeGFtcGxl
Lmh0bWwgWzFdCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgwMjExNDUx
OC5HQTIwOTI0QHJlZGhhdC5jb20vClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2
YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBpbmNsdWRlL2FzbS1nZW5lcmljL3ZtbGlu
dXgubGRzLmggfCAxMCArKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51
eC5sZHMuaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51eC5sZHMuaAppbmRleCBhZDZhZmM1
YzQ5MTguLmY2YTk5ZTVhYjQzOSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20tZ2VuZXJpYy92bWxp
bnV4Lmxkcy5oCisrKyBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51eC5sZHMuaApAQCAtOTEx
LDEzICs5MTEsMTEgQEAKICNkZWZpbmUgQ09OX0lOSVRDQUxMCQkJCQkJCVwKIAlCT1VOREVEX1NF
Q1RJT05fUE9TVF9MQUJFTCguY29uX2luaXRjYWxsLmluaXQsIF9fY29uX2luaXRjYWxsLCBfc3Rh
cnQsIF9lbmQpCiAKLSNkZWZpbmUgUlVOVElNRV9OQU1FKHQseCkgcnVudGltZV8jI3QjI18jI3gK
KyNkZWZpbmUgTkFNRURfU0VDVElPTihuYW1lKSBcCisJbmFtZSA6IEFUKEFERFIobmFtZSkgLSBM
T0FEX09GRlNFVCkgQUxJR04oOCkgXAorCXsgQk9VTkRFRF9TRUNUSU9OX1BSRV9MQUJFTChuYW1l
LCBuYW1lLCBfX3N0YXJ0XywgX19zdG9wXykgfQogCi0jZGVmaW5lIFJVTlRJTUVfQ09OU1QodCx4
KQkJCQkJCVwKLQkuID0gQUxJR04oOCk7CQkJCQkJCVwKLQlSVU5USU1FX05BTUUodCx4KSA6IEFU
KEFERFIoUlVOVElNRV9OQU1FKHQseCkpIC0gTE9BRF9PRkZTRVQpIHsJXAotCQkqKFJVTlRJTUVf
TkFNRSh0LHgpKTsJCQkJCVwKLQl9CisjZGVmaW5lIFJVTlRJTUVfQ09OU1QodCx4KSBOQU1FRF9T
RUNUSU9OKHJ1bnRpbWVfIyN0IyNfIyN4KQogCiAvKiBBbGlnbm1lbnQgbXVzdCBiZSBjb25zaXN0
ZW50IHdpdGggKGt1bml0X3N1aXRlICopIGluIGluY2x1ZGUva3VuaXQvdGVzdC5oICovCiAjZGVm
aW5lIEtVTklUX1RBQkxFKCkJCQkJCQkJXAotLSAKMi40Ni4wLnJjMS41LmcxZWJhNDJhMDIxCgo=
--0000000000008f8e3b061ebd3c5d--

