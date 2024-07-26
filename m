Return-Path: <linux-kernel+bounces-263759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ED793DA36
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B1428499E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B110E149E0C;
	Fri, 26 Jul 2024 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOm6YhBl"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726181859
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029823; cv=none; b=tDzW+ZcqK9P/1Jptnbb7UzHGT8PT3KVDV6sd6py8XQe7UI3NO1BVQXxaG5N8OrpyhrwWYQMH2agCFRm55D6TpNDARM5wJ/31jhGdePqcCX+i0ekpyapbLARs4446t/RkB0w4cSJj+7i4+GD7xhdvae2tyUK2vDLaPRuD8j0CPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029823; c=relaxed/simple;
	bh=aP1dtPog6wFtS0RnvmZTv6zCZsfwmj0Ai3bdWKmsmig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alKJW+ZB8q7exRmH/p1LjEKmhHL753PTaKXUzT3YwZN8ealMJWViz/fmRAuRDgTkDeh2vACoBe8IJnbZrJPELPbNWosZRxw7udM3U2DRxj/jjaVehBMpMsFYzLgGQfA4PlTFshe+gjmHB2wB+4D67m4gaI2kYZMoAmoPh+z0eHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOm6YhBl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc346ceso3343876a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722029819; x=1722634619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tR7QK+rFRo8OTFjA+KTJMc1hqekqtaMP08BMkpFD0zY=;
        b=WOm6YhBlQv/T/wT27pjLhpJcjgw6QS5h6HGXo22u9A7gyJHa6hUow3YteyR3ElV6TJ
         81gss8NasfGyV0eWrsgQg590RvuE/kfJKrRTRpUSyiGPP0ATanXEip/EL8KDCt1ElN11
         HQf8D1om4o+GDA5zUoZqHbMPabdbHRER5jri0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722029819; x=1722634619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tR7QK+rFRo8OTFjA+KTJMc1hqekqtaMP08BMkpFD0zY=;
        b=lvG6tLf4Nqos8PfXq0s/TFZx4z19z5whAX/EXaruVGm1UTqZMrFHZZaPVic5NkredG
         CpDwDJdB9ihFL72FXt9dUsozZgoo49P5wjbVMnpbLDcxyBLsOpsOrBIZrw8TmXnaUAvF
         S1xDY+zHNmIhUTArhnzbGPfhkpRqsXqJ9d8JJ2y6MOoP3F6Bm0G6sbKjsvKAyQXAT9dK
         lTcnsJluTCgsW3+gnbuYKLQUT97UxLH9KYtwnSCUwTK21vNxpF0TX14CGNF32D2DwTyb
         ZF8WO97yRZrYKWsRN2c+PVV3RF7meL4Iexuw5svO3CCd4z2mv0E8oOrDGfDKPt4z2k7x
         c5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXpbM/nZ64tEdLA2R5Y0XEQq7AOBs0ieaNkkU/HuCHat56NDD1JCWNLFxjSBgPXKy/0nYBkvM3kZbnqKZbm6tR90aw24DBO6s0ZbxIE
X-Gm-Message-State: AOJu0YyVIw+PCbSVj5Cz8h2Onwk1deStwT8RxoQfwj9iwoiYn49Owfc0
	FWD6RwxBCHpjTskYfQeK1XEY96HOgXvUM1TweJczchXYGeG7yz4txMnjWnBN3ugjrsX/2La51Co
	0nTuwlg==
X-Google-Smtp-Source: AGHT+IGj/vcqqpvJwGxoEKqHtLntwpiMlFu3QxG7nJ83UEGeygDGBYAJdQGgIofyWec7OzlY7wGFYg==
X-Received: by 2002:a17:907:7209:b0:a77:f2c5:84b3 with SMTP id a640c23a62f3a-a7d40057776mr54638066b.22.1722029819471;
        Fri, 26 Jul 2024 14:36:59 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9ef91sm213571366b.183.2024.07.26.14.36.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 14:36:57 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc346ceso3343844a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:36:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUns/c0y7bs0LCPGX+QQd1a4E6zxVCU7/AAq+Es2Lo5br49slNKyLn4T6FRmGLfDtr1oPe5PCE1TCn2HJRq5+7yFoxMvz8kyuskV3CJ
X-Received: by 2002:a50:aa9b:0:b0:5a2:9683:2bb6 with SMTP id
 4fb4d7f45d1cf-5b020101651mr373039a12.1.1722029817285; Fri, 26 Jul 2024
 14:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local> <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local> <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local> <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
In-Reply-To: <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 26 Jul 2024 14:36:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
Message-ID: <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="0000000000008d8e98061e2d4ffa"

--0000000000008d8e98061e2d4ffa
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 12:21, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> A simple comparison pre-revert vs. post-revert gives some ideas for other
> low-hanging fruit:
>
>   1334256./mm/compaction.o.pre

LOL. At least some of that is because of 'pageblock_order', which
expands to 2.5kB of text just because of this:

  /*
   * Huge pages are a constant size, but don't exceed the maximum allocation
   * granularity.
   */
  #define pageblock_order    min_t(unsigned int, HUGETLB_PAGE_ORDER,
MAX_PAGE_ORDER)

I think the two arguments to "min_t" are literally "(21 - 12)" and
"10", and it expands to 2.5kB.

So it _looks_ like "pageblock_order", and it *acts* like a simple
compile-time constant, but our complex type-checking min() macro ends
up making it horrible.

But no, that's not nearly the longest expansion. Writing a little
script, and I get

   Longest line is 85061 (253kB)

so we have a single expansion that is 253kB in size. And it comes from this:

                case ISOLATE_SUCCESS:
                        update_cached = false;
                        last_migrated_pfn = max(cc->zone->zone_start_pfn,
                                pageblock_start_pfn(cc->migrate_pfn - 1));

where that "max()" ends up interacting with "pageblock_start_pfn()",
and that pageblock_start_pfn() thing is

  #define pageblock_nr_pages      (1UL << pageblock_order)
  #define pageblock_start_pfn(pfn)  ALIGN_DOWN((pfn), pageblock_nr_pages)

so once again it's "pageblock_order", it's just that it's now mixed in
with "max()".

Now, fixing that, and you end up with

  Longest line is 61861 (82kB)

so it's now "only" 82kB in size, and that actually comes from
<linux/bio.h>, which has this:

   static inline unsigned bio_segments(struct bio *bio)
   {
   ...
        bio_for_each_segment(bv, bio, iter)
                segs++;

which looks very tame indeed, but it turns out that
"bio_for_each_segment()" expands to 82kB of code.

Jens? Maybe time to look into this?

               Linus

--0000000000008d8e98061e2d4ffa
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lz382o320>
X-Attachment-Id: f_lz382o320

IGFyY2gveDg2L3hlbi9zZXR1cC5jICAgICAgICAgICAgfCA1ICsrKy0tCiBpbmNsdWRlL2xpbnV4
L21pbm1heC5oICAgICAgICAgIHwgNyArKysrKysrCiBpbmNsdWRlL2xpbnV4L3BhZ2VibG9jay1m
bGFncy5oIHwgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL3NldHVwLmMgYi9hcmNoL3g4Ni94
ZW4vc2V0dXAuYwppbmRleCBhMGMzZTc3ZTNkNWIuLjgwNmRkYjIzOTFkOSAxMDA2NDQKLS0tIGEv
YXJjaC94ODYveGVuL3NldHVwLmMKKysrIGIvYXJjaC94ODYveGVuL3NldHVwLmMKQEAgLTY5MCw2
ICs2OTAsNyBAQCBjaGFyICogX19pbml0IHhlbl9tZW1vcnlfc2V0dXAodm9pZCkKIAlzdHJ1Y3Qg
eGVuX21lbW9yeV9tYXAgbWVtbWFwOwogCXVuc2lnbmVkIGxvbmcgbWF4X3BhZ2VzOwogCXVuc2ln
bmVkIGxvbmcgZXh0cmFfcGFnZXMgPSAwOworCXVuc2lnbmVkIGxvbmcgbWF4bWVtX3BhZ2VzOwog
CWludCBpOwogCWludCBvcDsKIApAQCAtNzYxLDggKzc2Miw4IEBAIGNoYXIgKiBfX2luaXQgeGVu
X21lbW9yeV9zZXR1cCh2b2lkKQogCSAqIE1ha2Ugc3VyZSB3ZSBoYXZlIG5vIG1lbW9yeSBhYm92
ZSBtYXhfcGFnZXMsIGFzIHRoaXMgYXJlYQogCSAqIGlzbid0IGhhbmRsZWQgYnkgdGhlIHAybSBt
YW5hZ2VtZW50LgogCSAqLwotCWV4dHJhX3BhZ2VzID0gbWluMyhFWFRSQV9NRU1fUkFUSU8gKiBt
aW4obWF4X3BmbiwgUEZOX0RPV04oTUFYTUVNKSksCi0JCQkgICBleHRyYV9wYWdlcywgbWF4X3Bh
Z2VzIC0gbWF4X3Bmbik7CisJbWF4bWVtX3BhZ2VzID0gRVhUUkFfTUVNX1JBVElPICogbWluKG1h
eF9wZm4sIFBGTl9ET1dOKE1BWE1FTSkpOworCWV4dHJhX3BhZ2VzID0gbWluMyhtYXhtZW1fcGFn
ZXMsIGV4dHJhX3BhZ2VzLCBtYXhfcGFnZXMgLSBtYXhfcGZuKTsKIAlpID0gMDsKIAlhZGRyID0g
eGVuX2U4MjBfdGFibGUuZW50cmllc1swXS5hZGRyOwogCXNpemUgPSB4ZW5fZTgyMF90YWJsZS5l
bnRyaWVzWzBdLnNpemU7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21pbm1heC5oIGIvaW5j
bHVkZS9saW51eC9taW5tYXguaAppbmRleCAyZWM1NTkyODRhOWYuLjVlMGMwMmE4N2QwOCAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9taW5tYXguaAorKysgYi9pbmNsdWRlL2xpbnV4L21pbm1h
eC5oCkBAIC03LDYgKzcsMTMgQEAKICNpbmNsdWRlIDxsaW51eC9jb25zdC5oPgogI2luY2x1ZGUg
PGxpbnV4L3R5cGVzLmg+CiAKKy8qCisgKiBVc2UgdGhlc2UgY2FyZWZ1bGx5OiBubyB0eXBlIGNo
ZWNraW5nLCBhbmQgdXNlcyB0aGUgYXJndW1lbnRzCisgKiBtdWx0aXBsZSB0aW1lcy4gVXNlIGZv
ciBvYnZpb3VzIGNvbnN0YW50cyBvbmx5LgorICovCisjZGVmaW5lIENPTlNUX01JTihhLGIpICgo
YSk8KGIpPyhhKTooYikpCisjZGVmaW5lIENPTlNUX01BWChhLGIpICgoYSk+KGIpPyhhKTooYikp
CisKIC8qCiAgKiBtaW4oKS9tYXgoKS9jbGFtcCgpIG1hY3JvcyBtdXN0IGFjY29tcGxpc2ggdGhy
ZWUgdGhpbmdzOgogICoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGFnZWJsb2NrLWZsYWdz
LmggYi9pbmNsdWRlL2xpbnV4L3BhZ2VibG9jay1mbGFncy5oCmluZGV4IDU0N2U4MmNkYzg5YS4u
Y2UxYjdjNGQ1N2UyIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3BhZ2VibG9jay1mbGFncy5o
CisrKyBiL2luY2x1ZGUvbGludXgvcGFnZWJsb2NrLWZsYWdzLmgKQEAgLTQxLDEzICs0MSwxMyBA
QCBleHRlcm4gdW5zaWduZWQgaW50IHBhZ2VibG9ja19vcmRlcjsKICAqIEh1Z2UgcGFnZXMgYXJl
IGEgY29uc3RhbnQgc2l6ZSwgYnV0IGRvbid0IGV4Y2VlZCB0aGUgbWF4aW11bSBhbGxvY2F0aW9u
CiAgKiBncmFudWxhcml0eS4KICAqLwotI2RlZmluZSBwYWdlYmxvY2tfb3JkZXIJCW1pbl90KHVu
c2lnbmVkIGludCwgSFVHRVRMQl9QQUdFX09SREVSLCBNQVhfUEFHRV9PUkRFUikKKyNkZWZpbmUg
cGFnZWJsb2NrX29yZGVyCSgodW5zaWduZWQgaW50KUNPTlNUX01JTihIVUdFVExCX1BBR0VfT1JE
RVIsIE1BWF9QQUdFX09SREVSKSkKIAogI2VuZGlmIC8qIENPTkZJR19IVUdFVExCX1BBR0VfU0la
RV9WQVJJQUJMRSAqLwogCiAjZWxpZiBkZWZpbmVkKENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFH
RSkKIAotI2RlZmluZSBwYWdlYmxvY2tfb3JkZXIJCW1pbl90KHVuc2lnbmVkIGludCwgSFBBR0Vf
UE1EX09SREVSLCBNQVhfUEFHRV9PUkRFUikKKyNkZWZpbmUgcGFnZWJsb2NrX29yZGVyICgodW5z
aWduZWQgaW50KUNPTlNUX01JTihIUEFHRV9QTURfT1JERVIsIE1BWF9QQUdFX09SREVSKSkKIAog
I2Vsc2UgLyogQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQQUdFICovCiAK
--0000000000008d8e98061e2d4ffa
Content-Type: text/x-csrc; charset="US-ASCII"; name="longest-line.c"
Content-Disposition: attachment; filename="longest-line.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lz382uw01>
X-Attachment-Id: f_lz382uw01

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5o
PgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KCnN0YXRpYyB2b2lkIGRpZShjb25zdCBjaGFyICpyZWFz
b24pCnsKCWZwcmludGYoc3RkZXJyLCAiRmF0YWw6ICVzXG4iLCByZWFzb24pOwoJZXhpdCgxKTsK
fQoKc3RhdGljIHVuc2lnbmVkIGxvbmcgZmluZF9saW5lKGNvbnN0IGNoYXIgKmxpbmUsIHVuc2ln
bmVkIGxvbmcgbGVuKQp7Cgl1bnNpZ25lZCBsb25nIHJlcyA9IDA7CglkbyB7CgkJcmVzKys7CgkJ
aWYgKCpsaW5lID09ICdcbicpCgkJCWJyZWFrOwoJCWxpbmUrKzsKCX0gd2hpbGUgKC0tbGVuKTsK
CXJldHVybiByZXM7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKewoJc3RydWN0
IHN0YXQgc3Q7CgljaGFyICpidWY7Cgl1bnNpZ25lZCBsb25nIGxlbjsKCWxvbmcgbG9uZ2VzdCA9
IDA7CgljaGFyICpsaW5lID0gIiI7CglpbnQgbGluZW5vID0gMCwgaTsKCglpZiAoZnN0YXQoMCwg
JnN0KSkgZGllKCJzdGF0Iik7CglpZiAoIVNfSVNSRUcoc3Quc3RfbW9kZSkpIGRpZSgiTm90IGEg
cmVndWxhcmZpbGUiKTsKCWxlbiA9IHN0LnN0X3NpemU7CglidWYgPSBtYWxsb2MobGVuKTsKCWlm
ICghYnVmKSBkaWUoIm1hbGxvYyBmYWlsZWQiKTsKCWlmIChyZWFkKDAsIGJ1ZiwgbGVuKSAhPSBs
ZW4pIGRpZSgicmVhZCBmYWlsZWQiKTsKCglmb3IgKGkgPSAxOyBsZW47IGkrKykgewoJCXVuc2ln
bmVkIGxvbmcgbGluZWxlbjsKCQlsaW5lbGVuID0gZmluZF9saW5lKGJ1ZiwgbGVuKTsKCQlpZiAo
bGluZWxlbiA+IGxvbmdlc3QpIHsKCQkJbG9uZ2VzdCA9IGxpbmVsZW47CgkJCWxpbmUgPSBidWY7
CgkJCWxpbmVubyA9IGk7CgkJfQoJCWJ1ZiArPSBsaW5lbGVuOwoJCWxlbiAtPSBsaW5lbGVuOwoJ
fQoKCXByaW50ZigiTG9uZ2VzdCBsaW5lIGlzICVkICglbHVrQilcbiIsIGxpbmVubywgKGxvbmdl
c3QrNTEyKSAvIDEwMjQpOwoJcHJpbnRmKCIgICAnJS4qcydcbiIsIChpbnQpIGxvbmdlc3QtMSwg
bGluZSk7CglyZXR1cm4gMDsKfQo=
--0000000000008d8e98061e2d4ffa--

