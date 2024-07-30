Return-Path: <linux-kernel+bounces-266743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AD6940627
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3061C21EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6441465BA;
	Tue, 30 Jul 2024 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NZNZxosg"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F1ED268
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312011; cv=none; b=YWXcD1lB7IRRpebFZsfmmSth04qEbyZvF8L9eCOB4liFcln38lM5b2yGLmws0uZxlUDEulrh+1/2jZ+L5Kryj9vfCePRbBfvzuAqZgkVNGthUuAKsLvAw78jyEUVYD1jGJ30Dmu4VPcgMvV3cgAV/+BH8nm1Gd/AmaS9iUFY590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312011; c=relaxed/simple;
	bh=9gz3Z7d0TMnM+YRdrZXUipQS+nt+zVaO1ywDwhACXfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae61pDWvx1Y042aUAxYymiMV0dnEjX/2CkD4VuSROa91SC66Hi6j+HduvhUGJDn3SXjMXYSFq5D8YZ+e+KL6HAFAZVaCOd4+7tA57gsAfFCSQPKAIvgZDM3PhaWo3lfl+1XDq/9RgcbJrgoOAcGFua51n1Z86aHQd+krWw/v4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NZNZxosg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efc89dbedso5086820e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722312007; x=1722916807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJcsS1pAGRRpD2UlNB3E64NAdJCM7937FS6P9MgJ0YA=;
        b=NZNZxosgf9kr4xsUI5tIZQGQItrkLGNQY/K3XfgpCPqxxvboyryJTDX3Rb21tzYwpf
         UqxFfThiXYZzPxe191crniYuW4kMGJJDMkLNMuzTYeIgS6pZYGOnmY4xP3C4qZTAwRZK
         /0k5ShFOBjapzo47f6DzjO0T8toAAE8L/q8Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722312007; x=1722916807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJcsS1pAGRRpD2UlNB3E64NAdJCM7937FS6P9MgJ0YA=;
        b=TP4HDaAd4MmdiAZ6YjItuUFPq65QZ2lT67CxLT6ZVvrjLsWAU0fWARvpagcUcPp9OQ
         qq2aEIq6M14jZU5CBRp+MwMlWW8WVQJDV9NYYSZzfTtkeSVvXkZW/Uuqa9tqJipSD0+S
         KJBPqvAZz5EZVNGqZTbsJSuRdS5kUVqMzDmRptjjge/3G9aGYapSGir+oj0JQCZe/6nM
         qSZqOkZ6UmF8Q2h2jisAZxxiCfCZ1tr0u48YDz+dQCUJVSapAo0VkWle2q4lxzk1sa8r
         PZQztxhpDRfTdzRqyGm4/utAjYtLFrHPMftTbvKfbeO8CZlB9Nx1StWJXDgL5IyIk4g3
         TTxw==
X-Forwarded-Encrypted: i=1; AJvYcCVrp+H7uWbvyaCNV0eAvKnqDV3++P1HEjZdeFuG98rbi4VzTKt/lW3yyY0gFBTLeDMDbA9MgAfC5bnU2QDzKcaoTzZ4CvW5plm3D+te
X-Gm-Message-State: AOJu0YzuyIIe2We6YS0ZtJP5fA7L/Sa2cnhr0DlJYcm74cDDcML6Zwt6
	ViW8UOMTo5HBUSD13cUIQ/LMs3RWqBrMoMKuOHpRzTf1pgKk7JkSZnokImos1FCHZ3ehm012THU
	6cDeZoA==
X-Google-Smtp-Source: AGHT+IEqBZCu9zWAJI0tsvFlYpyb8cOEVeZsYP9o4ESSOp1CXKq1q1oPSFSndMbQseSRX6X51i8HGw==
X-Received: by 2002:a05:6512:ba6:b0:52e:fd75:f060 with SMTP id 2adb3069b0e04-5309b2e0b43mr6211887e87.61.1722312006685;
        Mon, 29 Jul 2024 21:00:06 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c3925esm1710589e87.295.2024.07.29.21.00.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 21:00:04 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso57095441fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:00:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdakC8bFlfE+PWNNg+zV4ebhYWljeSfiUx/v7c24vzjQUZ079EQ6xTBmNMjhYpb4pvfJuA2zV6pEKCZ+SnPwMUExwfSr/6nFeUR2m9
X-Received: by 2002:a2e:9416:0:b0:2f0:1f06:2b43 with SMTP id
 38308e7fff4ca-2f12ee6a3fdmr65502441fa.41.1722312004170; Mon, 29 Jul 2024
 21:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com> <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com> <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com> <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com> <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
In-Reply-To: <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 29 Jul 2024 20:59:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com>
Message-ID: <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: Arnd Bergmann <arnd@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: multipart/mixed; boundary="000000000000345083061e6f0395"

--000000000000345083061e6f0395
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 16:21, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> Attached is the patch I have in my tree right now - it complains about
> a 'bcachefs' comparison between an 'u16' and a 's64', because I also
> removed the 'implicit integer promotion is ok' logic, because I think
> it's wrong.
>
> I don't think a min(u16,s64) is a valid minimum, for exactly the same
> reason a min(u32,s64) is not valid.

Oh, and I noticed that it screws up the 32-bit case, and that does
need a workaround for that.

So here's a better version. The patch contains one possible fix to
bcachefs for the type confusion there, but I'll wait for Kent to
respond on that.

             Linus

--000000000000345083061e6f0395
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lz7w2otm0>
X-Attachment-Id: f_lz7w2otm0

IGZzL2JjYWNoZWZzL2FsbG9jX2JhY2tncm91bmQuaCB8ICAyICstCiBpbmNsdWRlL2xpbnV4L2Nv
bXBpbGVyLmggICAgICAgfCAgOSArKysrKysKIGluY2x1ZGUvbGludXgvbWlubWF4LmggICAgICAg
ICB8IDY2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMyBmaWxl
cyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9mcy9iY2FjaGVmcy9hbGxvY19iYWNrZ3JvdW5kLmggYi9mcy9iY2FjaGVmcy9hbGxvY19iYWNr
Z3JvdW5kLmgKaW5kZXggOGQyYjYyYzk1ODhlLi5iNjFiOTJiZjdiYTkgMTAwNjQ0Ci0tLSBhL2Zz
L2JjYWNoZWZzL2FsbG9jX2JhY2tncm91bmQuaAorKysgYi9mcy9iY2FjaGVmcy9hbGxvY19iYWNr
Z3JvdW5kLmgKQEAgLTg3LDcgKzg3LDcgQEAgc3RhdGljIGlubGluZSBzNjQgYmNoMl9idWNrZXRf
c2VjdG9yc190b3RhbChzdHJ1Y3QgYmNoX2FsbG9jX3Y0IGEpCiAJcmV0dXJuIGEuc3RyaXBlX3Nl
Y3RvcnMgKyBhLmRpcnR5X3NlY3RvcnMgKyBhLmNhY2hlZF9zZWN0b3JzOwogfQogCi1zdGF0aWMg
aW5saW5lIHM2NCBiY2gyX2J1Y2tldF9zZWN0b3JzX2RpcnR5KHN0cnVjdCBiY2hfYWxsb2NfdjQg
YSkKK3N0YXRpYyBpbmxpbmUgdTY0IGJjaDJfYnVja2V0X3NlY3RvcnNfZGlydHkoc3RydWN0IGJj
aF9hbGxvY192NCBhKQogewogCXJldHVybiBhLnN0cmlwZV9zZWN0b3JzICsgYS5kaXJ0eV9zZWN0
b3JzOwogfQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9jb21waWxlci5oIGIvaW5jbHVkZS9s
aW51eC9jb21waWxlci5oCmluZGV4IDI1OTQ1NTNiYjMwYi4uMmRmNjY1ZmEyOTY0IDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgKKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxl
ci5oCkBAIC0yOTYsNiArMjk2LDE1IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCAqb2Zmc2V0X3RvX3B0
cihjb25zdCBpbnQgKm9mZikKICNkZWZpbmUgaXNfc2lnbmVkX3R5cGUodHlwZSkgKCgodHlwZSko
LTEpKSA8IChfX2ZvcmNlIHR5cGUpMSkKICNkZWZpbmUgaXNfdW5zaWduZWRfdHlwZSh0eXBlKSAo
IWlzX3NpZ25lZF90eXBlKHR5cGUpKQogCisvKgorICogVXNlZnVsIHNob3J0aGFuZCBmb3IgImlz
IHRoaXMgY29uZGl0aW9uIGtub3duIGF0IGNvbXBpbGUtdGltZT8iCisgKgorICogTm90ZSB0aGF0
IHRoZSBjb25kaXRpb24gbWF5IGludm9sdmUgbm9uLWNvbnN0YW50IHZhbHVlcywKKyAqIGJ1dCB0
aGUgY29tcGlsZXIgbWF5IGtub3cgZW5vdWdoIGFib3V0IHRoZSBkZXRhaWxzIG9mIHRoZQorICog
dmFsdWVzIHRvIGRldGVybWluZSB0aGF0IHRoZSBjb25kaXRpb24gaXMgc3RhdGljYWxseSB0cnVl
LgorICovCisjZGVmaW5lIHN0YXRpY2FsbHlfdHJ1ZSh4KSAoX19idWlsdGluX2NvbnN0YW50X3Ao
eCkgJiYgKHgpKQorCiAvKgogICogVGhpcyBpcyBuZWVkZWQgaW4gZnVuY3Rpb25zIHdoaWNoIGdl
bmVyYXRlIHRoZSBzdGFjayBjYW5hcnksIHNlZQogICogYXJjaC94ODYva2VybmVsL3NtcGJvb3Qu
Yzo6c3RhcnRfc2Vjb25kYXJ5KCkgZm9yIGFuIGV4YW1wbGUuCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L21pbm1heC5oIGIvaW5jbHVkZS9saW51eC9taW5tYXguaAppbmRleCBlM2U0MzUzZGY5
ODMuLmFmNTNlYmUzZDJiOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9taW5tYXguaAorKysg
Yi9pbmNsdWRlL2xpbnV4L21pbm1heC5oCkBAIC0yNiwxOSArMjYsNTIgQEAKICNkZWZpbmUgX190
eXBlY2hlY2soeCwgeSkgXAogCSghIShzaXplb2YoKHR5cGVvZih4KSAqKTEgPT0gKHR5cGVvZih5
KSAqKTEpKSkKIAotLyogaXNfc2lnbmVkX3R5cGUoKSBpc24ndCBhIGNvbnN0ZXhwciBmb3IgcG9p
bnRlciB0eXBlcyAqLwotI2RlZmluZSBfX2lzX3NpZ25lZCh4KSAJCQkJCQkJCVwKLQlfX2J1aWx0
aW5fY2hvb3NlX2V4cHIoX19pc19jb25zdGV4cHIoaXNfc2lnbmVkX3R5cGUodHlwZW9mKHgpKSks
CVwKLQkJaXNfc2lnbmVkX3R5cGUodHlwZW9mKHgpKSwgMCkKKy8qCisgKiBfX3NpZ25fdXNlIGZv
ciBpbnRlZ2VyIGV4cHJlc3Npb25zOgorICogICBiaXQgIzAgc2V0IGlmIG9rIGZvciB1bnNpZ25l
ZCBjb21wYXJpc29ucworICogICBiaXQgIzEgc2V0IGlmIG9rIGZvciBzaWduZWQgY29tcGFyaXNv
bnMKKyAqCisgKiBJbiBwYXJ0aWN1bGFyLCBub24tbmVnYXRpdmUgaW50ZWdlciBleHByZXNzaW9u
cworICogYXJlIG9rIGZvciBib3RoLgorICoKKyAqIE5vdGUgdGhhdCAneCcgaXMgdGhlIG9yaWdp
bmFsIGV4cHJlc3Npb24sIGFuZCAndXgnCisgKiBpcyB0aGUgdW5pcXVlIHZhcmlhYmxlIHRoYXQg
Y29udGFpbnMgdGhlIHZhbHVlLgorICoKKyAqIFdlIHVzZSAndXgnIGZvciBwdXJlIHR5cGUgY2hl
Y2tpbmcsIGFuZCAneCcgZm9yCisgKiB3aGVuIHdlIG5lZWQgdG8gbG9vayBhdCB0aGUgdmFsdWUg
KGJ1dCB3aXRob3V0CisgKiBldmFsdWF0aW5nIGl0IGZvciBzaWRlIGVmZmVjdHMhIENhcmVmdWwg
dG8gb25seQorICogZXZhbHVhdGUgaXQgd2l0aCBfX2J1aWx0aW5fY29uc3RhbnRfcCgpIGV0YykK
KyAqLworI2RlZmluZSBfX3NpZ25fdXNlKHgsdXgpIFwKKwkoaXNfc2lnbmVkX3R5cGUodHlwZW9m
KHV4KSk/MitfX2lzX25vbm5lZyh4LHV4KToxKQogCi0vKiBUcnVlIGZvciBhIG5vbi1uZWdhdGl2
ZSBzaWduZWQgaW50IGNvbnN0YW50ICovCi0jZGVmaW5lIF9faXNfbm9uZWdfaW50KHgpCVwKLQko
X19idWlsdGluX2Nob29zZV9leHByKF9faXNfY29uc3RleHByKHgpICYmIF9faXNfc2lnbmVkKHgp
LCB4LCAtMSkgPj0gMCkKKy8qCisgKiBUbyBhdm9pZCB3YXJuaW5ncyBhYm91dCBjYXN0aW5nIHBv
aW50ZXJzIHRvIGludGVnZXJzCisgKiBvZiBkaWZmZXJlbnQgc2l6ZXMsIHdlIG5lZWQgdGhhdCBz
cGVjaWFsIHNpZ24gdHlwZS4KKyAqCisgKiBPbiA2NC1iaXQgd2UgY2FuIGp1c3QgYWx3YXlzIHVz
ZSAnbG9uZycsIHNpbmNlIGFueQorICogaW50ZWdlciBvciBwb2ludGVyIHR5cGUgY2FuIGp1c3Qg
YmUgY2FzdCB0byB0aGF0LgorICoKKyAqIFRoaXMgZG9lcyBub3Qgd29yayBmb3IgMTI4LWJpdCBz
aWduZWQgaW50ZWdlcnMgc2luY2UKKyAqIHRoZSBjYXN0IHdvdWxkIHRydW5jYXRlIHRoZW0sIGJ1
dCB3ZSBkbyBub3QgdXNlIHMxMjgKKyAqIHR5cGVzIGluIHRoZSBrZXJuZWwgKHdlIGRvIHVzZSAn
dTEyOCcsIGJ1dCB0aGV5IHdpbGwKKyAqIGJlIGhhbmRsZWQgYnkgdGhlICFpc19zaWduZWRfdHlw
ZSgpIGNhc2UpLgorICoKKyAqIE5PVEUhIFRoZSBjYXN0IGlzIHRoZXJlIG9ubHkgdG8gYXZvaWQg
YW55IHdhcm5pbmdzCisgKiBmcm9tIHdoZW4gdmFsdWVzIHRoYXQgYXJlbid0IHNpZ25lZCBpbnRl
Z2VyIHR5cGVzLgorICovCisjaWZkZWYgQ09ORklHXzY0QklUCisgICNkZWZpbmUgX19zaWduZWRf
dHlwZSh1eCkgbG9uZworI2Vsc2UKKyAgI2RlZmluZSBfX3NpZ25lZF90eXBlKHV4KSB0eXBlb2Yo
X19idWlsdGluX2Nob29zZV9leHByKHNpemVvZih1eCk+MzIsMUxMLDFMKSkKKyNlbmRpZgorI2Rl
ZmluZSBfX2lzX25vbm5lZyh4LHV4KSBzdGF0aWNhbGx5X3RydWUoKF9fc2lnbmVkX3R5cGUodXgp
KSh4KT49MCkKIAotI2RlZmluZSBfX3R5cGVzX29rKHgsIHksIHV4LCB1eSkgCQkJCVwKLQkoX19p
c19zaWduZWQodXgpID09IF9faXNfc2lnbmVkKHV5KSB8fAkJCVwKLQkgX19pc19zaWduZWQoKHV4
KSArIDApID09IF9faXNfc2lnbmVkKCh1eSkgKyAwKSB8fAlcCi0JIF9faXNfbm9uZWdfaW50KHgp
IHx8IF9faXNfbm9uZWdfaW50KHkpKQorI2RlZmluZSBfX3R5cGVzX29rKHgseSx1eCx1eSkgXAor
CShfX3NpZ25fdXNlKHgsdXgpICYgX19zaWduX3VzZSh5LHV5KSkKKworI2RlZmluZSBfX3R5cGVz
X29rMyh4LHkseix1eCx1eSx1eikgXAorCShfX3NpZ25fdXNlKHgsdXgpICYgX19zaWduX3VzZSh5
LHV5KSAmIF9fc2lnbl91c2Uoeix1eikpCiAKICNkZWZpbmUgX19jbXBfb3BfbWluIDwKICNkZWZp
bmUgX19jbXBfb3BfbWF4ID4KQEAgLTUzLDggKzg2LDggQEAKIAogI2RlZmluZSBfX2NhcmVmdWxf
Y21wX29uY2Uob3AsIHgsIHksIHV4LCB1eSkgKHsJCVwKIAlfX2F1dG9fdHlwZSB1eCA9ICh4KTsg
X19hdXRvX3R5cGUgdXkgPSAoeSk7CVwKLQlzdGF0aWNfYXNzZXJ0KF9fdHlwZXNfb2soeCwgeSwg
dXgsIHV5KSwJCVwKLQkJI29wICIoIiAjeCAiLCAiICN5ICIpIHNpZ25lZG5lc3MgZXJyb3IsIGZp
eCB0eXBlcyBvciBjb25zaWRlciB1IiAjb3AgIigpIGJlZm9yZSAiICNvcCAiX3QoKSIpOyBcCisJ
QlVJTERfQlVHX09OX01TRyghX190eXBlc19vayh4LHksdXgsdXkpLAlcCisJCSNvcCIoIiN4Iiwg
IiN5Iikgc2lnbmVkbmVzcyBlcnJvciIpOwlcCiAJX19jbXAob3AsIHV4LCB1eSk7IH0pCiAKICNk
ZWZpbmUgX19jYXJlZnVsX2NtcChvcCwgeCwgeSkgXApAQCAtNjcsMTEgKzEwMCwxMCBAQAogCV9f
YXV0b190eXBlIHV2YWwgPSAodmFsKTsJCQkJCQlcCiAJX19hdXRvX3R5cGUgdWxvID0gKGxvKTsJ
CQkJCQkJXAogCV9fYXV0b190eXBlIHVoaSA9IChoaSk7CQkJCQkJCVwKLQlzdGF0aWNfYXNzZXJ0
KF9fYnVpbHRpbl9jaG9vc2VfZXhwcihfX2lzX2NvbnN0ZXhwcigobG8pID4gKGhpKSksIAlcCi0J
CQkobG8pIDw9IChoaSksIHRydWUpLAkJCQkJXAorCUJVSUxEX0JVR19PTl9NU0coc3RhdGljYWxs
eV90cnVlKHVsbyA+IHVoaSksCQkJCVwKIAkJImNsYW1wKCkgbG93IGxpbWl0ICIgI2xvICIgZ3Jl
YXRlciB0aGFuIGhpZ2ggbGltaXQgIiAjaGkpOwlcCi0Jc3RhdGljX2Fzc2VydChfX3R5cGVzX29r
KHV2YWwsIGxvLCB1dmFsLCB1bG8pLCAiY2xhbXAoKSAnbG8nIHNpZ25lZG5lc3MgZXJyb3IiKTsJ
XAotCXN0YXRpY19hc3NlcnQoX190eXBlc19vayh1dmFsLCBoaSwgdXZhbCwgdWhpKSwgImNsYW1w
KCkgJ2hpJyBzaWduZWRuZXNzIGVycm9yIik7CVwKKwlCVUlMRF9CVUdfT05fTVNHKCFfX3R5cGVz
X29rMyh2YWwsbG8saGksdXZhbCx1bG8sdWhpKSwJCQlcCisJCSJjbGFtcCgiI3ZhbCIsICIjbG8i
LCAiI2hpIikgc2lnbmVkbmVzcyBlcnJvciIpOwkJXAogCV9fY2xhbXAodXZhbCwgdWxvLCB1aGkp
OyB9KQogCiAjZGVmaW5lIF9fY2FyZWZ1bF9jbGFtcCh2YWwsIGxvLCBoaSkgXAo=
--000000000000345083061e6f0395--

