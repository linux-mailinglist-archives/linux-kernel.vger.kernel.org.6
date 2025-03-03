Return-Path: <linux-kernel+bounces-542723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5FBA4CCE3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86A13AB097
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB21EF094;
	Mon,  3 Mar 2025 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DQONpwR8"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928891C8FB5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034793; cv=none; b=FkQWg+6+rJeMUb8AE9DncX1cG5/1hM4j7TVpB6WzBrkse05+fIU5U20z4VuRZ9goKgUDE+rAzZ5hNA3mE/apAmhBZdOByAd8e3KiuvCGEz6x2l7NRicy7I4K+/1fypROgC2cKjcgJUnUZgeTcf8Kpt1NTY+oPUnP1KJALhtiUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034793; c=relaxed/simple;
	bh=/TSvSx+n/7h75HAByI0XmaklVwSreC1/YD2z85/rnbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGeatV0HVgDXmx4sKlIPeYGZmzvIJA8xDag7zWs6q6GqLhMTYJi2jskUlsvwAm+vyNHP43c0o8XmiBYDPt0jVOxBswuBmyDQBAOjgH8N6O4V6p7eabq4x1qi3bSja2h/mEw9vfJdOJrixetZPHvk3dJNyQ3ZwPReYTpqwSLdpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DQONpwR8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso8614888a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741034789; x=1741639589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N8giJnezX3CtMdKV60CgQxT4SKIJQ9hhEThxu7GG34A=;
        b=DQONpwR8GdmUprl69kljMoDmtaYsXqTeglhA4gw3loiPbjZpnIiRUF2XCTfDMwM5bP
         9veQD3sbAPUXwkdKlrWWDIp4u57YWat94hSZqM82xgxGSL/SfP/JpQQ4Y/wFvzVEFjyK
         d8fDDdSAcDW+hxuyFx7xSW57frnQxJkU76lwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741034789; x=1741639589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8giJnezX3CtMdKV60CgQxT4SKIJQ9hhEThxu7GG34A=;
        b=LodrcMoejNRl3XobkKrWEXBAQ5Y902ty+K7m6heMowlPuY+BT9Eg+MLcId0b2E18Vr
         A/Dwa69e3UapCcLUx7Ehb6Ad+veGpZHr9K1t/BoXg1hA8WXA54cJnJY46GVVs5loaG1V
         FWc3WUHek6CIEsM8Dd2f6PgYgRuLtJKS25NdBlp9LjckR2QmBbDpRoeZqLQ52kD3prvM
         EyzFlYXrJmaoK9KAiky1hbJJATThfJC/Xcuyflbpat4t+T72VwwnHTmPp1Ntf8uQ4rcn
         BcWqSQM/KuagrzTY/EUDPIZ6vB11CsAmvJS8Fbd1DRx62/A7uQeOHHP14vm2vyC1SyRY
         MIMw==
X-Forwarded-Encrypted: i=1; AJvYcCXJdc3HYWeXo7FB2AeJvc6bIGwY7Rdrh4Uni2xyI9QhxXQ9wpuVeXOoWhJrw7DF6lgBguwuVjpPEXm/kcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyByQ/QSQY7C7pE1B+iPr47rT0sf7RNFg6EPByKkKWbjPnVfDXn
	3SuXO5CC7eR5MzCSKQcoKxpKBDQFct9nNkObVX4hiM74Gpsi82hFH7i2XpA1NW5RMLYyiOLjxCh
	kztg=
X-Gm-Gg: ASbGnctLpCmhlBj/7ZdtfjL4DMRbRfeFOGbf5UAflKmO8TX1aVPjR1DEWl3T2/Ey/EM
	1RCFpoG+Vfca78Qs3lrS0bJMLhriyJFkt/Z4+W4Sg/4ad3a5i3WWmQ6D7HgTiyewuzBj8hb5uxD
	yexOMetbTngvG3TInarYLTkXm233ngRjoJhwVUqAilT1aIUtEXFD281S/gmAqbBc6wP5ungy0B+
	E0vf0QYFtTXvL7vjxse67CmcHrDuP4OpYNKxfbBJKxqESU8GAbS0K6jTbX0NqHlAG9BqEv6onfw
	B4i5GrLthUABdPbTT+Du8OLGFDJTzBk8/J5eYvCCrDZx+wUf0R4NbI0m6CmUnEDZnUXCw+eZqMM
	b/bLjcMEyZBxaePlmLw0=
X-Google-Smtp-Source: AGHT+IHQXitL1iFkThBwtJp1RGdvA5mM+mCD6QOgPGwXsqlWqdPECzvLXxgd9Akedo9HSIM3tjwGNw==
X-Received: by 2002:a17:907:3fa9:b0:ac1:eec4:91f7 with SMTP id a640c23a62f3a-ac1eec4925fmr117264566b.27.1741034788773;
        Mon, 03 Mar 2025 12:46:28 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac00b19ae66sm203438466b.121.2025.03.03.12.46.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 12:46:27 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf5f4e82caso386969866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:46:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWp6ecF/PH7IeOCbh3jtisq4ustgRNLFEkhuMgtSIuXwQRAhF9HDcGxa84iVoPNrNGowiDvdpNSFXxxyng=@vger.kernel.org
X-Received: by 2002:a17:907:3fa9:b0:ac1:eec4:91f7 with SMTP id
 a640c23a62f3a-ac1eec4925fmr117255866b.27.1741034787283; Mon, 03 Mar 2025
 12:46:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com> <20250303202735.GD9870@redhat.com>
In-Reply-To: <20250303202735.GD9870@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Mar 2025 10:46:10 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
X-Gm-Features: AQ5f1JqBdfS3OsjWtvaQ1iJbyRmzh1AYJAvBekLXzynzy8xNvLqN0Ww6oCUKFIc
Message-ID: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: multipart/mixed; boundary="0000000000000a0263062f764049"

--0000000000000a0263062f764049
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 10:28, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Stupid question... but do we really need to change the code which update
> tail/head if we pack them into a single word?

No. It's only the READ_ONCE() parts that need changing.

See this suggested patch, which does something very similar to what
you were thinking of.

ENTIRELY UNTESTED, but it seems to generate ok code. It might even
generate better code than what we have now.

               Linus

--0000000000000a0263062f764049
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m7tj52z80>
X-Attachment-Id: f_m7tj52z80

IGZzL3BpcGUuYyAgICAgICAgICAgICAgICAgfCAxOSArKysrKysrKy0tLS0tLS0tLS0tCiBpbmNs
dWRlL2xpbnV4L3BpcGVfZnNfaS5oIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2ZzL3BpcGUuYyBiL2ZzL3BpcGUuYwppbmRleCBjZTFhZjc1OTI3
ODAuLjk3Y2M3MDU3MjYwNiAxMDA2NDQKLS0tIGEvZnMvcGlwZS5jCisrKyBiL2ZzL3BpcGUuYwpA
QCAtMjEwLDExICsyMTAsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwaXBlX2J1Zl9vcGVyYXRp
b25zIGFub25fcGlwZV9idWZfb3BzID0gewogLyogRG9uZSB3aGlsZSB3YWl0aW5nIHdpdGhvdXQg
aG9sZGluZyB0aGUgcGlwZSBsb2NrIC0gdGh1cyB0aGUgUkVBRF9PTkNFKCkgKi8KIHN0YXRpYyBp
bmxpbmUgYm9vbCBwaXBlX3JlYWRhYmxlKGNvbnN0IHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBp
cGUpCiB7Ci0JdW5zaWduZWQgaW50IGhlYWQgPSBSRUFEX09OQ0UocGlwZS0+aGVhZCk7Ci0JdW5z
aWduZWQgaW50IHRhaWwgPSBSRUFEX09OQ0UocGlwZS0+dGFpbCk7CisJdW5pb24gcGlwZV9pbmRl
eCBpZHggPSB7IFJFQURfT05DRShwaXBlLT5oZWFkX3RhaWwpIH07CiAJdW5zaWduZWQgaW50IHdy
aXRlcnMgPSBSRUFEX09OQ0UocGlwZS0+d3JpdGVycyk7CiAKLQlyZXR1cm4gIXBpcGVfZW1wdHko
aGVhZCwgdGFpbCkgfHwgIXdyaXRlcnM7CisJcmV0dXJuICFwaXBlX2VtcHR5KGlkeC5oZWFkLCBp
ZHgudGFpbCkgfHwgIXdyaXRlcnM7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHBp
cGVfdXBkYXRlX3RhaWwoc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwKQEAgLTQxNywxMSAr
NDE2LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IGlzX3BhY2tldGl6ZWQoc3RydWN0IGZpbGUgKmZp
bGUpCiAvKiBEb25lIHdoaWxlIHdhaXRpbmcgd2l0aG91dCBob2xkaW5nIHRoZSBwaXBlIGxvY2sg
LSB0aHVzIHRoZSBSRUFEX09OQ0UoKSAqLwogc3RhdGljIGlubGluZSBib29sIHBpcGVfd3JpdGFi
bGUoY29uc3Qgc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSkKIHsKLQl1bnNpZ25lZCBpbnQg
aGVhZCA9IFJFQURfT05DRShwaXBlLT5oZWFkKTsKLQl1bnNpZ25lZCBpbnQgdGFpbCA9IFJFQURf
T05DRShwaXBlLT50YWlsKTsKKwl1bmlvbiBwaXBlX2luZGV4IGlkeCA9IHsgUkVBRF9PTkNFKHBp
cGUtPmhlYWRfdGFpbCkgfTsKIAl1bnNpZ25lZCBpbnQgbWF4X3VzYWdlID0gUkVBRF9PTkNFKHBp
cGUtPm1heF91c2FnZSk7CiAKLQlyZXR1cm4gIXBpcGVfZnVsbChoZWFkLCB0YWlsLCBtYXhfdXNh
Z2UpIHx8CisJcmV0dXJuICFwaXBlX2Z1bGwoaWR4LmhlYWQsIGlkeC50YWlsLCBtYXhfdXNhZ2Up
IHx8CiAJCSFSRUFEX09OQ0UocGlwZS0+cmVhZGVycyk7CiB9CiAKQEAgLTY1OSw3ICs2NTcsNyBA
QCBwaXBlX3BvbGwoc3RydWN0IGZpbGUgKmZpbHAsIHBvbGxfdGFibGUgKndhaXQpCiB7CiAJX19w
b2xsX3QgbWFzazsKIAlzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlID0gZmlscC0+cHJpdmF0
ZV9kYXRhOwotCXVuc2lnbmVkIGludCBoZWFkLCB0YWlsOworCXVuaW9uIHBpcGVfaW5kZXggaWR4
OwogCiAJLyogRXBvbGwgaGFzIHNvbWUgaGlzdG9yaWNhbCBuYXN0eSBzZW1hbnRpY3MsIHRoaXMg
ZW5hYmxlcyB0aGVtICovCiAJV1JJVEVfT05DRShwaXBlLT5wb2xsX3VzYWdlLCB0cnVlKTsKQEAg
LTY4MCwxOSArNjc4LDE4IEBAIHBpcGVfcG9sbChzdHJ1Y3QgZmlsZSAqZmlscCwgcG9sbF90YWJs
ZSAqd2FpdCkKIAkgKiBpZiBzb21ldGhpbmcgY2hhbmdlcyBhbmQgeW91IGdvdCBpdCB3cm9uZywg
dGhlIHBvbGwKIAkgKiB0YWJsZSBlbnRyeSB3aWxsIHdha2UgeW91IHVwIGFuZCBmaXggaXQuCiAJ
ICovCi0JaGVhZCA9IFJFQURfT05DRShwaXBlLT5oZWFkKTsKLQl0YWlsID0gUkVBRF9PTkNFKHBp
cGUtPnRhaWwpOworCWlkeC5oZWFkX3RhaWwgPSBSRUFEX09OQ0UocGlwZS0+aGVhZF90YWlsKTsK
IAogCW1hc2sgPSAwOwogCWlmIChmaWxwLT5mX21vZGUgJiBGTU9ERV9SRUFEKSB7Ci0JCWlmICgh
cGlwZV9lbXB0eShoZWFkLCB0YWlsKSkKKwkJaWYgKCFwaXBlX2VtcHR5KGlkeC5oZWFkLCBpZHgu
dGFpbCkpCiAJCQltYXNrIHw9IEVQT0xMSU4gfCBFUE9MTFJETk9STTsKIAkJaWYgKCFwaXBlLT53
cml0ZXJzICYmIGZpbHAtPmZfcGlwZSAhPSBwaXBlLT53X2NvdW50ZXIpCiAJCQltYXNrIHw9IEVQ
T0xMSFVQOwogCX0KIAogCWlmIChmaWxwLT5mX21vZGUgJiBGTU9ERV9XUklURSkgewotCQlpZiAo
IXBpcGVfZnVsbChoZWFkLCB0YWlsLCBwaXBlLT5tYXhfdXNhZ2UpKQorCQlpZiAoIXBpcGVfZnVs
bChpZHguaGVhZCwgaWR4LnRhaWwsIHBpcGUtPm1heF91c2FnZSkpCiAJCQltYXNrIHw9IEVQT0xM
T1VUIHwgRVBPTExXUk5PUk07CiAJCS8qCiAJCSAqIE1vc3QgVW5pY2VzIGRvIG5vdCBzZXQgRVBP
TExFUlIgZm9yIEZJRk9zIGJ1dCBvbiBMaW51eCB0aGV5CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3BpcGVfZnNfaS5oIGIvaW5jbHVkZS9saW51eC9waXBlX2ZzX2kuaAppbmRleCA4ZmYyM2Jm
NWE4MTkuLmIxYTNiOTlmOWZmOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9waXBlX2ZzX2ku
aAorKysgYi9pbmNsdWRlL2xpbnV4L3BpcGVfZnNfaS5oCkBAIC0zMSw2ICszMSwzMyBAQCBzdHJ1
Y3QgcGlwZV9idWZmZXIgewogCXVuc2lnbmVkIGxvbmcgcHJpdmF0ZTsKIH07CiAKKy8qCisgKiBS
ZWFsbHkgb25seSBhbHBoYSBuZWVkcyAzMi1iaXQgZmllbGRzLCBidXQKKyAqIG1pZ2h0IGFzIHdl
bGwgZG8gaXQgZm9yIDY0LWJpdCBhcmNoaXRlY3R1cmVzCisgKiBzaW5jZSB0aGF0J3Mgd2hhdCB3
ZSd2ZSBoaXN0b3JpY2FsbHkgZG9uZSwKKyAqIGFuZCBpdCBtYWtlcyAnaGVhZF90YWlsJyBhbHdh
eXMgYmUgYSBzaW1wbGUKKyAqICd1bnNpZ25lZCBsb25nJy4KKyAqLworI2lmZGVmIENPTkZJR182
NEJJVAorICB0eXBlZGVmIHVuc2lnbmVkIGludCBwaXBlX2luZGV4X3Q7CisjZWxzZQorICB0eXBl
ZGVmIHVuc2lnbmVkIHNob3J0IHBpcGVfaW5kZXhfdDsKKyNlbmRpZgorCisvKgorICogV2UgaGF2
ZSB0byBkZWNsYXJlIHRoaXMgb3V0c2lkZSAnc3RydWN0IHBpcGVfaW5vZGVfaW5mbycsCisgKiBi
dXQgdGhlbiB3ZSBjYW4ndCB1c2UgJ3VuaW9uIHBpcGVfaW5kZXgnIGZvciBhbiBhbm9ueW1vdXMK
KyAqIHVuaW9uLCBzbyB3ZSBlbmQgdXAgaGF2aW5nIHRvIGR1cGxpY2F0ZSB0aGlzIGRlY2xhcmF0
aW9uCisgKiBiZWxvdy4gQW5ub3lpbmcuCisgKi8KK3VuaW9uIHBpcGVfaW5kZXggeworCXVuc2ln
bmVkIGxvbmcgaGVhZF90YWlsOworCXN0cnVjdCB7CisJCXBpcGVfaW5kZXhfdCBoZWFkOworCQlw
aXBlX2luZGV4X3QgdGFpbDsKKwl9OworfTsKKwogLyoqCiAgKglzdHJ1Y3QgcGlwZV9pbm9kZV9p
bmZvIC0gYSBsaW51eCBrZXJuZWwgcGlwZQogICoJQG11dGV4OiBtdXRleCBwcm90ZWN0aW5nIHRo
ZSB3aG9sZSB0aGluZwpAQCAtNTgsOCArODUsMTYgQEAgc3RydWN0IHBpcGVfYnVmZmVyIHsKIHN0
cnVjdCBwaXBlX2lub2RlX2luZm8gewogCXN0cnVjdCBtdXRleCBtdXRleDsKIAl3YWl0X3F1ZXVl
X2hlYWRfdCByZF93YWl0LCB3cl93YWl0OwotCXVuc2lnbmVkIGludCBoZWFkOwotCXVuc2lnbmVk
IGludCB0YWlsOworCisJLyogVGhpcyBoYXMgdG8gbWF0Y2ggdGhlICd1bmlvbiBwaXBlX2luZGV4
JyBhYm92ZSAqLworCXVuaW9uIHsKKwkJdW5zaWduZWQgbG9uZyBoZWFkX3RhaWw7CisJCXN0cnVj
dCB7CisJCQlwaXBlX2luZGV4X3QgaGVhZDsKKwkJCXBpcGVfaW5kZXhfdCB0YWlsOworCQl9Owor
CX07CisKIAl1bnNpZ25lZCBpbnQgbWF4X3VzYWdlOwogCXVuc2lnbmVkIGludCByaW5nX3NpemU7
CiAJdW5zaWduZWQgaW50IG5yX2FjY291bnRlZDsK
--0000000000000a0263062f764049--

