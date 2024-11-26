Return-Path: <linux-kernel+bounces-422795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEBD9D9E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE915283ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164631DED7F;
	Tue, 26 Nov 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fcc23bZE"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10B1AAD7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651958; cv=none; b=MXnK9D0PX8qjJqETK0V1G+0oWUNRnYN5jQMWQY+13SJ0eZARg0bDU0XmB0quofM4jQf5faR5lHu+5Lu1m4L6DtgJhWxeH6VeTqJXj1IADI9GfFtyhBT+ceHt7W4CFb7Jw1eiBRGWdELG1bf/P2cFzR32qDNcD1BvaB3JAoeM2vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651958; c=relaxed/simple;
	bh=uWrUI/pysQhZIfRTeItGGFWEydtMBGYiFOohLBDWNyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ7aHjVQKRjgzrhA9krtw1Vpe7Ls5lbgnta9ERP7+kkCtTPrnqY59Z8orJB4E9QWQrhM0gnvC7fXNFipneWCj8h8EsBZ2Fe1ag97nx6ZY/jiCF7Lwr/PQznBJjg3J8SSD/5sDo9RV8IbfSXpznxdmisGDXQtt/O2/wTpu4jEgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fcc23bZE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa535eed875so545534466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732651954; x=1733256754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OsmMiNRefRTL0MlPSivhIcGYc2/1gcxWz7piPbzNRz0=;
        b=Fcc23bZEOBRqMAR02LscG2GT2QMPXUsZdkm9/Wn7QsQewzWAVkMwOdMcRNlky2nalV
         jq++OWKevBKrYpbqQTcLxwAJo40vpewTGH6X27Eb4UX+ZZAKL4jLMXbno9Zkq9oUGSco
         kMSgBO55mLAIm1cmlNaD38qImDdOrelkn7eJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732651954; x=1733256754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsmMiNRefRTL0MlPSivhIcGYc2/1gcxWz7piPbzNRz0=;
        b=aMDai72gms8B2zxRXJr5wECq2DKhxCddDC8d1TtCQTct/ZrHFPBHeFELpuzMC4d0RQ
         QTKyuMFcX9eqpkMkLA1blPJv1ejHX3NDxC1jI4R4cA+OavX5P0ICdgC58z1oF0AR4avB
         8oVLf/tUAVdTCAQiYwYJyONHAzpfQwqf/UW1dtWa0cJZgowW+wiXARQPgMXpE/Rlpn+e
         zBtfA+TYQ2Uvhhh8JgBv+KGBAA9tQGp/aBHQ9MtggHtm6AMKY+MI6B3OdPRNidUM0MFN
         Rw6qpeDwgl178t3yZWDzLQV0TzpgDHXsxHraqN+S7hwhfFTt2OT+nkptPRUiCjAzKGzN
         GDNA==
X-Gm-Message-State: AOJu0YxJV8zLWX00PLHoiGKrl/RmZni77OrVpIfZpC6fm75DLWnQvghW
	WQGj8CqQ75dQXEK/LD8bOvJY4n8gl326AljBANcODlc6GdprpNFa2SNQnA197IsaEpWGM23wEOd
	ypvf9og==
X-Gm-Gg: ASbGncvRkpc68/kiSy/gB87YgQydQIegimxfMSmTHV3Nk64OUfdk90U+giBg7YlpRyZ
	auGKTMI3W9qhgwWnowZIMTojtcNSemj5tRWwq3NzWC3rv6o4lnImtcUt26LR824z+Z0MrA0H5Y+
	LWt9pWgyKdJSSbtcIPPfTHqPHJBUZXoDQJKYCkcX3QwxsjvbrVnwc95dDUEBU8sMfwR2EoDoWx3
	pMHQV/DLxhlta+NVT6AVjdSomgkjgxuCd+vHw/wzvKJvwGm9sqU0nfh9O+gS7ieupdhnP53dGGt
	28unG3BfeC+B51wrVUUbKj7F
X-Google-Smtp-Source: AGHT+IFHuPgPPOYT/nb7+9Bwdj3C5HHZ8vuNXc9l+GfC4fZr9tk01PXZTJwQMGtsdwsDqbITsrCM0g==
X-Received: by 2002:a17:907:7852:b0:aa5:1d0c:3671 with SMTP id a640c23a62f3a-aa580f2c498mr19638766b.23.1732651954264;
        Tue, 26 Nov 2024 12:12:34 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2efbf1sm626405866b.44.2024.11.26.12.12.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 12:12:33 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e8522445dso840445866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:12:33 -0800 (PST)
X-Received: by 2002:a17:907:7637:b0:aa5:4adc:5a1f with SMTP id
 a640c23a62f3a-aa580f58e93mr18245566b.33.1732651953081; Tue, 26 Nov 2024
 12:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411210651.CD8B5A3B98@keescook> <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org> <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
In-Reply-To: <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 12:12:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjF_09Z6vu7f8UAbQVDDoHnd-j391YpUxmBPLD=SKbKtQ@mail.gmail.com>
Message-ID: <CAHk-=wjF_09Z6vu7f8UAbQVDDoHnd-j391YpUxmBPLD=SKbKtQ@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Nir Lichtman <nir@lichtman.org>, Tycho Andersen <tandersen@netflix.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: multipart/mixed; boundary="0000000000002f255a0627d678f1"

--0000000000002f255a0627d678f1
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 12:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So something like the attached. But it's *ENTIRELY* untested. [..]

It was also entirely un-attached. Here's the actual attachment.

           Linus

--0000000000002f255a0627d678f1
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m3yw84x00>
X-Attachment-Id: f_m3yw84x00

IGZzL2V4ZWMuYyAgICAgICAgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKystLS0t
CiBpbmNsdWRlL2xpbnV4L2JpbmZtdHMuaCB8ICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9leGVjLmMgYi9mcy9l
eGVjLmMKaW5kZXggZGE1MWNhNzA0ODlhLi44NTA0MjE0NDVjY2IgMTAwNjQ0Ci0tLSBhL2ZzL2V4
ZWMuYworKysgYi9mcy9leGVjLmMKQEAgLTExOTQsMTIgKzExOTQsMjIgQEAgc3RhdGljIGludCB1
bnNoYXJlX3NpZ2hhbmQoc3RydWN0IHRhc2tfc3RydWN0ICptZSkKICAqIHNvIHRoYXQgYSBuZXcg
b25lIGNhbiBiZSBzdGFydGVkCiAgKi8KIAorLyoKKyAqIE5vIGxvY2tpbmcsIGluc3RlYWQgdGhp
cyBqdXN0IG1ha2VzIHN1cmUgdGhhdCBjb21tW10gaXMgYWx3YXlzCisgKiBOVUwtdGVybWluYXRl
ZC4gTm90ZSB0aGF0ICdzdHJzY3B5X3BhZCgpJyBkb2VzIG5vdCBndWFyYW50ZWUKKyAqIHRoYXQg
YXQgbGVhc3QgcmlnaHQgbm93IC0gaXQgbWF5IGRvIHRoZSBjb3B5IHdpdGhvdXQgYSBOVUwgYW5k
CisgKiB0aGVuIG92ZXJ3cml0ZSB0aGUgbGFzdCBjaGFyYWN0ZXIuCisgKgorICogT25lIG9mIHRo
ZSBmZXcgY2FzZXMgd2hlcmUgJ3N0cm5jcHkoKScgZG9lcyB0aGUgcmlnaHQgdGhpbmcuCisgKgor
ICogSWYgeW91IGRvIGNvbmN1cnJlbnQgc2V0X3Rhc2tfY29tbSgpIGNhbGxzLCB0aGUgbmFtZSBt
YXkgYmUKKyAqIGEgYml0IHJhbmRvbSwgYnV0IGl0J3MgZ29pbmcgdG8gYmUgTlVMLXRlcm1pbmF0
ZWQuCisgKi8KIHZvaWQgX19zZXRfdGFza19jb21tKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLCBj
b25zdCBjaGFyICpidWYsIGJvb2wgZXhlYykKIHsKLQl0YXNrX2xvY2sodHNrKTsKIAl0cmFjZV90
YXNrX3JlbmFtZSh0c2ssIGJ1Zik7Ci0Jc3Ryc2NweV9wYWQodHNrLT5jb21tLCBidWYsIHNpemVv
Zih0c2stPmNvbW0pKTsKLQl0YXNrX3VubG9jayh0c2spOworCXRzay0+Y29tbVtzaXplb2YodHNr
LT5jb21tKS0xXSA9IDA7CisJc3RybmNweSh0c2stPmNvbW0sIGJ1Ziwgc2l6ZW9mKHRzay0+Y29t
bSktMSk7CiAJcGVyZl9ldmVudF9jb21tKHRzaywgZXhlYyk7CiB9CiAKQEAgLTEzMzcsNyArMTM0
Nyw3IEBAIGludCBiZWdpbl9uZXdfZXhlYyhzdHJ1Y3QgbGludXhfYmlucHJtICogYnBybSkKIAkJ
c2V0X2R1bXBhYmxlKGN1cnJlbnQtPm1tLCBTVUlEX0RVTVBfVVNFUik7CiAKIAlwZXJmX2V2ZW50
X2V4ZWMoKTsKLQlfX3NldF90YXNrX2NvbW0obWUsIGtiYXNlbmFtZShicHJtLT5maWxlbmFtZSks
IHRydWUpOworCV9fc2V0X3Rhc2tfY29tbShtZSwgYnBybS0+Y29tbSwgdHJ1ZSk7CiAKIAkvKiBB
biBleGVjIGNoYW5nZXMgb3VyIGRvbWFpbi4gV2UgYXJlIG5vIGxvbmdlciBwYXJ0IG9mIHRoZSB0
aHJlYWQKIAkgICBncm91cCAqLwpAQCAtMTUxMCw2ICsxNTIwLDExIEBAIHN0YXRpYyBzdHJ1Y3Qg
bGludXhfYmlucHJtICphbGxvY19icHJtKGludCBmZCwgc3RydWN0IGZpbGVuYW1lICpmaWxlbmFt
ZSwgaW50IGZsCiAKIAlpZiAoZmQgPT0gQVRfRkRDV0QgfHwgZmlsZW5hbWUtPm5hbWVbMF0gPT0g
Jy8nKSB7CiAJCWJwcm0tPmZpbGVuYW1lID0gZmlsZW5hbWUtPm5hbWU7CisJCS8qCisJCSAqIEZJ
WE1FKD8pOiB0aGlzIGNvdWxkIHRha2UgYWR2YW50YWdlIG9mICdmaWxlbmFtZS0+bGVuJworCQkg
KiB0byBkbyBiZXR0ZXIgdGhhbiBrYmFzZW5hbWUoKQorCQkgKi8KKwkJc3Ryc2NweShicHJtLT5j
b21tLCBrYmFzZW5hbWUoZmlsZW5hbWUtPm5hbWUpKTsKIAl9IGVsc2UgewogCQlpZiAoZmlsZW5h
bWUtPm5hbWVbMF0gPT0gJ1wwJykKIAkJCWJwcm0tPmZkcGF0aCA9IGthc3ByaW50ZihHRlBfS0VS
TkVMLCAiL2Rldi9mZC8lZCIsIGZkKTsKQEAgLTE1MzIsNiArMTU0NywxMCBAQCBzdGF0aWMgc3Ry
dWN0IGxpbnV4X2JpbnBybSAqYWxsb2NfYnBybShpbnQgZmQsIHN0cnVjdCBmaWxlbmFtZSAqZmls
ZW5hbWUsIGludCBmbAogCQkJYnBybS0+aW50ZXJwX2ZsYWdzIHw9IEJJTlBSTV9GTEFHU19QQVRI
X0lOQUNDRVNTSUJMRTsKIAogCQlicHJtLT5maWxlbmFtZSA9IGJwcm0tPmZkcGF0aDsKKworCQly
Y3VfcmVhZF9sb2NrKCk7CisJCXN0cnNjcHkoYnBybS0+Y29tbSwgc21wX2xvYWRfYWNxdWlyZSgm
ZmlsZS0+Zl9wYXRoLmRlbnRyeS0+ZF9uYW1lLm5hbWUpKTsKKwkJcmN1X3JlYWRfdW5sb2NrKCk7
CiAJfQogCWJwcm0tPmludGVycCA9IGJwcm0tPmZpbGVuYW1lOwogCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L2JpbmZtdHMuaCBiL2luY2x1ZGUvbGludXgvYmluZm10cy5oCmluZGV4IGU2YzAw
ZTg2MDk1MS4uM2M4YmM4NGNhOWU0IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2JpbmZtdHMu
aAorKysgYi9pbmNsdWRlL2xpbnV4L2JpbmZtdHMuaApAQCAtNjEsNiArNjEsNyBAQCBzdHJ1Y3Qg
bGludXhfYmlucHJtIHsKIAogCXN0cnVjdCBybGltaXQgcmxpbV9zdGFjazsgLyogU2F2ZWQgUkxJ
TUlUX1NUQUNLIHVzZWQgZHVyaW5nIGV4ZWMuICovCiAKKwljaGFyIGNvbW1bVEFTS19DT01NX0xF
Tl07CiAJY2hhciBidWZbQklOUFJNX0JVRl9TSVpFXTsKIH0gX19yYW5kb21pemVfbGF5b3V0Owog
Cg==
--0000000000002f255a0627d678f1--

