Return-Path: <linux-kernel+bounces-227336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C57914FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2622823A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DD9142E83;
	Mon, 24 Jun 2024 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KTnjnicK"
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B776A14265E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238693; cv=none; b=QT2Jt5U2pRtAQPyZ7/aaPrdlDDsbOhXVHD26FvgHTgSySXKoQoPT3Z25EgxksKugFxD871z43ASGxzMGGf/KTJZKCPX7jOGWuEd4HbD6hla9k/TxTaKfT540dX/yjkduRaNIlKGl3umzmZ4qhR5nNspfW4FIFLOfShzV9L4hFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238693; c=relaxed/simple;
	bh=rLRWDErId0Q0TapRIvr8XtQMDb1NH3QmR++MOnp8LiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3gzoxbbx+rRyKC7MfmHCNV3cFHiicVa5pwyUcjW/LBIOjZHR1l+qoYy6/I4IhEm0zp/HiWobgOHzuoA4swUF9zSWV9G9frn7CCHM/9pjhiG0XjSO/rhrsn/yavRwryHGl9F28UpZQWp8GRq2QuYmW5YYM96oUYxzf8PafI98wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KTnjnicK; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so55992211fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719238690; x=1719843490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PqogIz1q8VYByFnkcky9M/0brxP5HSw1VqQOzsX9vAQ=;
        b=KTnjnicKEcOh5Fv9Y7eHkAkAqjz4iETZtcDKwKS0kR9WyQZzZerLhwtO/7/yNk/icc
         nUSNabSWxw9UzmWrd2Y5vTY/0FhCMrEd7D+dO1BXUASRgzmAB3MJMj1ERIGyES6fNiUx
         bnurz2EIzrZVmipoVymBkASY/LKz1bq+hQJz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719238690; x=1719843490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqogIz1q8VYByFnkcky9M/0brxP5HSw1VqQOzsX9vAQ=;
        b=pIpLSiQhfeTWGNBBBXyLu3W5lWkDUXhd2Oz5VornMTnDFuLwyX/zQWHtCxm7PcPoB/
         RZ/53feQBQcwiMCMfvetnX+jXmdLbnQFwZUMwrzWJ2c1JGTcktvfcaovuTyU+mXxbtEm
         VV4SZK0RIhohQqGpgg+8DixeinDyyK3i+sikv7jkNjzOXYR42opbHEXFUAVGb5UCsrB9
         WQWr9iU0nBPC+bxvWzFYpAXSzv6D2iHReksi2F0bB2lse6jD7aKQkwPZHgmjSsMCv6pa
         M3wVayftVsrxH6d7EBjZ+DhmV1cdxh6PbLKhlcRIwujuz4iDb/HJjZSwtNG61OgCvtdN
         SEuA==
X-Forwarded-Encrypted: i=1; AJvYcCXgNbFzCMwkPSgAHYIp3KEy0pm8NNukP7/prD72qEf8+DJ6Ed4VgVjUWfIgiZ1SXZZxd2WP78pggYwmQZACoZ0aYO95zcM/gvgkww3N
X-Gm-Message-State: AOJu0Yyz9EdiIRNM8+XnVEZQhX/QYggewANk7/z/rF0UTGRz/Qpy2AcP
	TUvCPLp05bw1DwdA6DzK6GsrVCswxdPYxooIR7YWTySLu+4V9i0CwnJFhs0Y+GHgSRA0lqUxEme
	tPkJg0FTo
X-Google-Smtp-Source: AGHT+IGLAwbnvhDEyid2a907MS/JrhKuPpfuhuaFC9UDaTqLOyIMbLwT4MKSOVqpnnwxCSR6e4MQ+Q==
X-Received: by 2002:a2e:3018:0:b0:2ec:588d:7eb4 with SMTP id 38308e7fff4ca-2ec5b30bd1fmr36232541fa.15.1719238689596;
        Mon, 24 Jun 2024 07:18:09 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec5dd45476sm4577191fa.42.2024.06.24.07.18.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 07:18:08 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cdd893e5cso2228310e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:18:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAdp8rVSthwX8x8QmAE2Zb0KixZs8xVLwG0Qu95FypT1hrPYi6MhEqUEBUUpJU6KnNOQDtbBm1ZYdYvmtUTz8XrT2dlWZvkwAqwIVS
X-Received: by 2002:a05:6512:220c:b0:52c:d70d:5ff8 with SMTP id
 2adb3069b0e04-52ce1832692mr4052944e87.1.1719238688208; Mon, 24 Jun 2024
 07:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
 <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
 <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com>
 <CAFULd4YAeF7=q7DYUh016kabxS8b32qRbFqDBJQrvLq6RjwEVg@mail.gmail.com> <CAHk-=wiHo2YeA=TOUf8vxFLOc0+BoH8USaiT25fnX2ynXbrZkg@mail.gmail.com>
In-Reply-To: <CAHk-=wiHo2YeA=TOUf8vxFLOc0+BoH8USaiT25fnX2ynXbrZkg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Jun 2024 10:17:50 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgdCs0883dpvZpyna76q9eVcTMvvUVAaBuJMPyrgOhNig@mail.gmail.com>
Message-ID: <CAHk-=wgdCs0883dpvZpyna76q9eVcTMvvUVAaBuJMPyrgOhNig@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: multipart/mixed; boundary="0000000000004c66fc061ba373eb"

--0000000000004c66fc061ba373eb
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 09:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 24 Jun 2024 at 03:36, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > A real fix, not only a workaround, is to rewrite asm arguments to
> > something like (untested, but "should work"TM):
>
> Sadly, I already tried that, and it didn't help.

Bah. I _had_ tried that, but I had tried it on __arch_cmpxchg64_emu(),
not on the "try" version.

And no, it hadn't helped.

But doing it *right*, and also doing __arch_try_cmpxchg64_emu() *does*
actually help.

Well, at least the attached patch compiles with the bad config and clang.

I'm not certain it does the right thing, because I did more than just
the %esi games to try to simplify it.

It's *ENTIRELY* possible that I screwed up. Just in this thread, I
have looked at the wrong inline asm at least twice now, so I'm not
feeling super-competent right now.

I'm sending the patch out in the hope that another set of eyes will
make it actually better.

            Linus

--0000000000004c66fc061ba373eb
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lxt2b6hy0>
X-Attachment-Id: f_lxt2b6hy0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL2NtcHhjaGdfMzIuaCB8IDI4ICsrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jbXB4Y2hnXzMyLmggYi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9jbXB4Y2hnXzMyLmgKaW5kZXggZWQyNzk3ZjEzMmNlLi5iMTk5
ODU1MjBmM2MgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NtcHhjaGdfMzIuaAor
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jbXB4Y2hnXzMyLmgKQEAgLTg4LDE4ICs4OCwxNyBA
QCBzdGF0aWMgX19hbHdheXNfaW5saW5lIGJvb2wgX190cnlfY21weGNoZzY0X2xvY2FsKHZvbGF0
aWxlIHU2NCAqcHRyLCB1NjQgKm9sZHAsCiAKICNkZWZpbmUgX19hcmNoX2NtcHhjaGc2NF9lbXUo
X3B0ciwgX29sZCwgX25ldywgX2xvY2tfbG9jLCBfbG9jaykJXAogKHsJCQkJCQkJCQlcCi0JdW5p
b24gX191NjRfaGFsdmVzIG8gPSB7IC5mdWxsID0gKF9vbGQpLCB9LAkJCVwKLQkJCSAgIG4gPSB7
IC5mdWxsID0gKF9uZXcpLCB9OwkJCVwKKwlfX3U2NCBvID0gKF9vbGQpOwkJCQkJCVwKKwl1bmlv
biBfX3U2NF9oYWx2ZXMgbiA9IHsgLmZ1bGwgPSAoX25ldyksIH07CQkJXAogCQkJCQkJCQkJXAog
CWFzbSB2b2xhdGlsZShBTFRFUk5BVElWRShfbG9ja19sb2MJCQkJXAogCQkJCSAiY2FsbCBjbXB4
Y2hnOGJfZW11IiwJCQlcCi0JCQkJIF9sb2NrICJjbXB4Y2hnOGIgJVtwdHJdIiwgWDg2X0ZFQVRV
UkVfQ1g4KSBcCi0JCSAgICAgOiBbcHRyXSAiK20iICgqKF9wdHIpKSwJCQkJXAotCQkgICAgICAg
IithIiAoby5sb3cpLCAiK2QiIChvLmhpZ2gpCQkJXAotCQkgICAgIDogImIiIChuLmxvdyksICJj
IiAobi5oaWdoKSwgIlMiIChfcHRyKQkJXAorCQkJCSBfbG9jayAiY21weGNoZzhiIDAoJVtwdHJd
KSIsIFg4Nl9GRUFUVVJFX0NYOCkgXAorCQkgICAgIDogIitBIiAobykJCQkJCQlcCisJCSAgICAg
OiAiYiIgKG4ubG93KSwgImMiIChuLmhpZ2gpLCBbcHRyXSAiUyIgKF9wdHIpCVwKIAkJICAgICA6
ICJtZW1vcnkiKTsJCQkJCVwKIAkJCQkJCQkJCVwKLQlvLmZ1bGw7CQkJCQkJCQlcCisJbzsJCQkJ
CQkJCVwKIH0pCiAKIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdTY0IGFyY2hfY21weGNoZzY0KHZv
bGF0aWxlIHU2NCAqcHRyLCB1NjQgb2xkLCB1NjQgbmV3KQpAQCAtMTE2LDIyICsxMTUsMTkgQEAg
c3RhdGljIF9fYWx3YXlzX2lubGluZSB1NjQgYXJjaF9jbXB4Y2hnNjRfbG9jYWwodm9sYXRpbGUg
dTY0ICpwdHIsIHU2NCBvbGQsIHU2NAogCiAjZGVmaW5lIF9fYXJjaF90cnlfY21weGNoZzY0X2Vt
dShfcHRyLCBfb2xkcCwgX25ldywgX2xvY2tfbG9jLCBfbG9jaykJXAogKHsJCQkJCQkJCQlcCi0J
dW5pb24gX191NjRfaGFsdmVzIG8gPSB7IC5mdWxsID0gKihfb2xkcCksIH0sCQkJXAotCQkJICAg
biA9IHsgLmZ1bGwgPSAoX25ldyksIH07CQkJXAorCV9fdTY0IG8gPSAqKF9vbGRwKTsJCQkJCQlc
CisJdW5pb24gX191NjRfaGFsdmVzIG4gPSB7IC5mdWxsID0gKF9uZXcpLCB9OwkJCVwKIAlib29s
IHJldDsJCQkJCQkJXAogCQkJCQkJCQkJXAogCWFzbSB2b2xhdGlsZShBTFRFUk5BVElWRShfbG9j
a19sb2MJCQkJXAogCQkJCSAiY2FsbCBjbXB4Y2hnOGJfZW11IiwJCQlcCi0JCQkJIF9sb2NrICJj
bXB4Y2hnOGIgJVtwdHJdIiwgWDg2X0ZFQVRVUkVfQ1g4KSBcCisJCQkJIF9sb2NrICJjbXB4Y2hn
OGIgMCglW3B0cl0pIiwgWDg2X0ZFQVRVUkVfQ1g4KSBcCiAJCSAgICAgQ0NfU0VUKGUpCQkJCQkJ
XAotCQkgICAgIDogQ0NfT1VUKGUpIChyZXQpLAkJCQkJXAotCQkgICAgICAgW3B0cl0gIittIiAo
KihfcHRyKSksCQkJCVwKLQkJICAgICAgICIrYSIgKG8ubG93KSwgIitkIiAoby5oaWdoKQkJCVwK
LQkJICAgICA6ICJiIiAobi5sb3cpLCAiYyIgKG4uaGlnaCksICJTIiAoX3B0cikJCVwKKwkJICAg
ICA6IENDX09VVChlKSAocmV0KSwgIitBIiAobykJCQlcCisJCSAgICAgOiAiYiIgKG4ubG93KSwg
ImMiIChuLmhpZ2gpLCBbcHRyXSAiUyIgKF9wdHIpCVwKIAkJICAgICA6ICJtZW1vcnkiKTsJCQkJ
CVwKIAkJCQkJCQkJCVwKLQlpZiAodW5saWtlbHkoIXJldCkpCQkJCQkJXAotCQkqKF9vbGRwKSA9
IG8uZnVsbDsJCQkJCVwKKwkqKF9vbGRwKSA9IG87CQkJCQkJCVwKIAkJCQkJCQkJCVwKIAlsaWtl
bHkocmV0KTsJCQkJCQkJXAogfSkK
--0000000000004c66fc061ba373eb--

