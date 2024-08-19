Return-Path: <linux-kernel+bounces-291976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ED3956994
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F15B22317
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC386166F36;
	Mon, 19 Aug 2024 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG6C/Qku"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5B1662E8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067886; cv=none; b=jctAhJVvJOm0nbcr/9NLaBaDC6UUvCYbXZ/+Un8N5l00dGPkJbuddia7WeoCmWQLm2SWjiOhrJ+G8CfwdkeNJi0RGmSiLpxPLDgWL147ORI/NdqMiMh5x2b/GoBTwujbx7l77QU9i+NsIeEA3+LHB9x2Gbiaok8lc7jFt3FPbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067886; c=relaxed/simple;
	bh=3dm5jhhU1tb4Z93ZafF+6iMrIY69gXRErqdXw1h2T24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSGwrgj0z2ORoquFmi0m5HKRn6r/+OHGi+/5IVp9iVwLjVzDZhtg3yyyJpAJ1wjW9CyxbyRLwOeAieneL+QP3QW3rUQ8W/CVCfShe4aKvgVYX4DxlrYf/fGdZ2F0V0N27FSXfTis7PWjocq5h3+ksuvNRvxMeHb7j+LWQguPNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG6C/Qku; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f3ce5bc7b4so18168181fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724067882; x=1724672682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=odjopEvwH67dxv9w6eekXOxb49yPm4nXGo4n1/uD+2g=;
        b=CG6C/Qku943KlG+DrSD/umW96IqsaMFQ/6VBMJHN44Yluc65UXOQ1ZrCJJerX7rqRp
         k9gfye6DOyFTMg5/BSU9U+Ynvry1Wr/VcecHZoLtjuqUemtllJnt41qNTu4wvyjTEf68
         Au44Eadah6IFD5akc2ZMdcxQpVoJlEptbPRtqVgFFXJr4FwqxUbnLTbZU5eBYKwDmy3T
         0+ufDfChHNjyOKWveMiCBpN5iCsoYSiypHjeX2hDPxAotL6PvI4azIFU2NNKaBLB3sxi
         UF3/F+e3b0wBmI8vmyn96n4vcdC/HEcGy6mxnns7AtWuwHxT8lc7oFMW08HPFeR0QhKF
         4XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067882; x=1724672682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odjopEvwH67dxv9w6eekXOxb49yPm4nXGo4n1/uD+2g=;
        b=dKJX2lXtzxIgp3EbcLPQwI14dfX+uj8piWef0PLHWr5jHfs83R6fDEACDWMONOIv3H
         mEw6iGmoF2o8Jf2I9xms8UNy9rhvYWoh9t2DY68+MiLqmTIzygHJ5rDyFgLvH763ChFm
         565jfVpfYLyl/nRnxDgcK082cffSS1A6aWVizACJi+4d1T0FXv3v4+Z7OpxqW2zWt1SI
         LVLs7Z0ifB190f5GCFDFKK3iWhIfXQltaAu18jqTB8dLSPlwkVr8d8H4wmp5t6zIqiWh
         pemIeJPsmSrDVjQhe+/9nK3ChNjMzcnqW04RDdDNX8myq5mMm3hYIQLfAEqU6IElrGYO
         HF7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjIQ4Q5xzHq86Rx4DigL6lYe1mR7+hf/IK2Jbi480k/ibFQX2xOLWjhBVsM08g+qYCkP53q0q7/ilto4tw1HgCEZu2c8cwqYFwu/kJ
X-Gm-Message-State: AOJu0YyoGn+2m+NJ4b0RjqyKZ9GVKOVgNJPJ91CtK+vRWqo5v6g0Lhju
	jcLMSMW9LsOAUEJNjMn49PJpaYk5Q4BOnbdHSKIgVRgyYBqQi2rrHxMqjBxBwIiQx2RBGeLcdZS
	iQACFcGuePGvw143vM97yPk8eR7g=
X-Google-Smtp-Source: AGHT+IE6iUag+9k8LcZQ7Ws/9/lpqTS4a+bFfYRN5dOywfrtT3S1T+b3EIasvMiglZRrty9MSEU87+4Uo5NVYT57yl4=
X-Received: by 2002:a2e:1319:0:b0:2ef:2b53:c785 with SMTP id
 38308e7fff4ca-2f3be607459mr62202961fa.41.1724067881847; Mon, 19 Aug 2024
 04:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuFDon59=Nw6WCdgp0FanZ1oE3dCkoq71EK0Bxe6Jhe_g@mail.gmail.com>
 <CA+G9fYtd1Hw9YLpceUAwwC+UytVQVXOET4gmGT9jiCgHa+WexQ@mail.gmail.com>
In-Reply-To: <CA+G9fYtd1Hw9YLpceUAwwC+UytVQVXOET4gmGT9jiCgHa+WexQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 19 Aug 2024 19:44:25 +0800
Message-ID: <CAMgjq7Bz0DY+rY0XgCoH7-Q=uHLdo3omi8kUr4ePDweNyofsbQ@mail.gmail.com>
Subject: Re: gcc-8: mm/swapfile.c:863:40: error: array subscript 1 is above
 array bounds of 'struct list_head[1]' [-Werror=array-bounds]
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Chris Li <chrisl@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Barry Song <21cnbao@gmail.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000aaac9d062007d5df"

--000000000000aaac9d062007d5df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:16=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Mon, 19 Aug 2024 at 13:58, Naresh Kamboju <naresh.kamboju@linaro.org> =
wrote:
> >
> > The x86 builds failed with gcc-8 due to following build warnings / erro=
rs on
> > Linux next-20240802 to next-20240819.
> >
> > x86_64 defconfig gcc-8 build failed
> > x86_64 defconfig gcc-13 build pass
> >
> > First seen on the next-20240802 tag.
> >
> >   GOOD: next-20240730
> >   BAD:  next-20240802
>
> Anders bisected this and found the first bad commit id as,
> aded4352f648 ("mm: swap: separate SSD allocation from
> scan_swap_map_slots()") first faulty one
>
> - Naresh
>

Hi Naresh,

Thanks for the report, the problem will occur when CONFIG_THP_SWAP is
disabled. Can you try the following patch? I can confirm it's fixed
with my test.

--000000000000aaac9d062007d5df
Content-Type: application/octet-stream; 
	name="0001-mm-swap-fix-array-bounds-error-with-CONFIG_THP_SWAP-.patch"
Content-Disposition: attachment; 
	filename="0001-mm-swap-fix-array-bounds-error-with-CONFIG_THP_SWAP-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m00x6nue0>
X-Attachment-Id: f_m00x6nue0

RnJvbSA4OWYwYWFmYTAzYWQ1ODc4ZTg5MDJlMDdlMTJlYzBjMDIwZGJhMmRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlydWkgU29uZyA8a2Fzb25nQHRlbmNlbnQuY29tPgpEYXRl
OiBNb24sIDE5IEF1ZyAyMDI0IDE5OjMxOjU1ICswODAwClN1YmplY3Q6IFtQQVRDSF0gbW06IHN3
YXA6IGZpeCBhcnJheS1ib3VuZHMgZXJyb3Igd2l0aCBDT05GSUdfVEhQX1NXQVA9bgoKU2lnbmVk
LW9mZi1ieTogS2FpcnVpIFNvbmcgPGthc29uZ0B0ZW5jZW50LmNvbT4KLS0tCiBtbS9zd2FwZmls
ZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvbW0vc3dhcGZpbGUuYyBiL21tL3N3YXBmaWxlLmMKaW5kZXggZDljZjMx
YjA0ZGIzLi4xNmVjNmI3ZGYxOTggMTAwNjQ0Ci0tLSBhL21tL3N3YXBmaWxlLmMKKysrIGIvbW0v
c3dhcGZpbGUuYwpAQCAtODM2LDcgKzgzNiw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGNsdXN0
ZXJfYWxsb2Nfc3dhcF9lbnRyeShzdHJ1Y3Qgc3dhcF9pbmZvX3N0cnVjdCAqc2ksIGludCBvCiAJ
CWdvdG8gZG9uZTsKIAogCS8qIE9yZGVyIDAgc3RlYWxpbmcgZnJvbSBoaWdoZXIgb3JkZXIgKi8K
LQlmb3IgKGludCBvID0gMTsgbyA8IFBNRF9PUkRFUjsgbysrKSB7CisJZm9yIChpbnQgbyA9IDE7
IG8gPCBTV0FQX05SX09SREVSUzsgbysrKSB7CiAJCS8qCiAJCSAqIENsdXN0ZXJzIGhlcmUgaGF2
ZSBhdCBsZWFzdCBvbmUgdXNhYmxlIHNsb3RzIGFuZCBjYW4ndCBmYWlsIG9yZGVyIDAKIAkJICog
YWxsb2NhdGlvbiwgYnV0IHJlY2xhaW0gbWF5IGRyb3Agc2ktPmxvY2sgYW5kIHJhY2Ugd2l0aCBh
bm90aGVyIHVzZXIuCi0tIAoyLjQ1LjIKCg==
--000000000000aaac9d062007d5df--

