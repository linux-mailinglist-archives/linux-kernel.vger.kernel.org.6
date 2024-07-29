Return-Path: <linux-kernel+bounces-266518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9BF940106
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1B42821BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E8A18EFD8;
	Mon, 29 Jul 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaUjzzpB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024BC18E773
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291949; cv=none; b=QYzCwvwQnLHtHVi1IGusiX6hzl5iiewy0pyn29+d7qWdYs7WHAplFDIxhhZ2kLYyNbec4kmhj88140i4eCVj4cVGq3n7RWx5LrhTSCc6N0iVxrO6JRBXqFAQOUWRhAbqrJHQ68oMYe53kAN0TZoVYPIeOMvVjkggquKxMVFmI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291949; c=relaxed/simple;
	bh=UYuIFJJmj4BgxktN1lSVbRHAo0jV6eeqWnYdfES+CJ4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XoS4gmuQWWQWI9yxEomzmYJQrxBQ3xk25tKnjWgomHfdZZIBcSMvlPNTLFX1AzQJmYYCiKZ4DiN39xdtuFKcQpu4LWt7qJB5lkUFQYeBGDdXAD7XGX2yO/X4JrCpvvSG9d814AXne8Yt30gjBsQIbrfgEzKYqd+iS2j7wQzVhJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaUjzzpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E8CC32786;
	Mon, 29 Jul 2024 22:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722291948;
	bh=UYuIFJJmj4BgxktN1lSVbRHAo0jV6eeqWnYdfES+CJ4=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=VaUjzzpBX7Tj9hmz4Jl3PH+d/zm/TeYCp4MAT9Dc5OtYR3CFpdwKkROuyxtwA5iPC
	 Fv1JSkA/3Wk+b9+UIV2C8SAF7ZLAdb9nY2pGZdKjOMbrwpDgYW49Ch8Dg+yK8T6U19
	 H7eznbUjNaxlPontpGFBza4fiQqvSjAjw31i7HrEPpkFLyE7FBUccJaPedQESmaIJy
	 weAo4Dg3qZdhC+o1XgWaq6QJ8mF7Klghsat+wy/XpBQ8heiEJJ9OLbKGZQZRv4ATFM
	 m7i5dUwMzBszrXFo16cLVEma/Sprm/pIaTV2N5QBsz3kCk0Ux61cGAjppS8kOwhZwp
	 6mjASZKwkbz+A==
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E1AA11200066;
	Mon, 29 Jul 2024 18:25:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Mon, 29 Jul 2024 18:25:46 -0400
X-ME-Sender: <xms:6haoZmOTl--BF-16bffp5n46_NUNjKU_D6xokdtarQ13W_5j6JLsEg>
    <xme:6haoZk_PLjMCPhwuFXzoePQCbM1w37PNFhJ4AF612Xq5Unz722xajHcVE6VAAy22v
    VUP9bdVBNPDYusn4YM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeehudeg
    tdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddv
    gedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdrug
    gvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:6haoZtSWY2_u0qqPuoO8HxryDGf251jJbLdjPpU0Yyyq1FHJ6vquCg>
    <xmx:6haoZmscPQ9q375t0BKDVp7e5-GwPTPFEcJ3gqm4FzMHcjYzSkMB6g>
    <xmx:6haoZuf_dJ31uUOfNYEVqZTnyFDW5VRrAm22Zhkq7tJDvcSFGegMnQ>
    <xmx:6haoZq0bleS10zWNTX7IMITHAWDGdLVowsnzuNT8LkU-Ys0Q1DX_GQ>
    <xmx:6haoZi_Ic0ZOLSln-l4wmeGPbKWw6DMgr-yujxowAZX5cpQ_DHtwqtuL>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B043EB6008D; Mon, 29 Jul 2024 18:25:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com>
 <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com>
 <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
 <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
Date: Tue, 30 Jul 2024 00:25:24 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Linus Torvalds" <torvalds@linuxfoundation.org>,
 "David Laight" <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Matthew Wilcox" <willy@infradead.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
Content-Type: text/plain

On Sun, Jul 28, 2024, at 22:13, Linus Torvalds wrote:
> On Sun, 28 Jul 2024 at 13:10, David Laight <David.Laight@aculab.com> wrote:
>>
>> I think they just need to be MIN_CONST() (without the casts).
>
> I'll just convert the existing cases of min_t/max_t to MIN_T/MAX_T,
> which I already added for other reasons anyway.
>
> That makes min_t/max_t not have to care about the nasty special cases
> (really just array sizes in these cases, and they all wanted MAX_T).

I had prototyped something similar end of last week but didn't manage
to get my version out to you before the weekend. Comparing mine with
what you ended up committing:

- You found exactly the same array index uses I found in
  randconfig testing, so I'm not aware of anything missing
  there.

- My macros use __builtin_choose_expr() instead of ?: to
  ensure that the arguments are constant, this produces a
  relatively clear compiler warning when they are not.
  Without that, I would expect random drivers to start
  using MIN()/MAX() in places where it's not safe.

- I went with the belts-and-suspenders version of MIN()/MAX()
  that works when comparing a negative constant against
  an unsigned one. This requires expanding each argument
  four or five times instead of two, so you might still
  want the simpler version (like MIN_T/MAX_T):

--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -295,12 +271,18 @@ static inline bool in_range32(u32 val, u32 start, u32 len)
        do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
 /*
- * Use these carefully: no type checking, and uses the arguments
- * multiple times. Use for obvious constants only.
+ * These only work on constant values but return a constant value that
+ * can be used as an array size
  */
-#define MIN(a,b) __cmp(min,a,b)
-#define MAX(a,b) __cmp(max,a,b)
-#define MIN_T(type,a,b) __cmp(min,(type)(a),(type)(b))
-#define MAX_T(type,a,b) __cmp(max,(type)(a),(type)(b))
+#define MIN(x, y) \
+   __builtin_choose_expr(((x) < 0 && (y) > 0), (x), \
+   __builtin_choose_expr((((y) < 0 && (x) > 0) || (y) < (x)), (y), (x)))
+
+#define MAX(x, y) \
+   __builtin_choose_expr(((x) > 0 && (y) < 0), (x), \
+   __builtin_choose_expr((((y) > 0 && (x) < 0) || (y) > (x)), (y), (x)))
+
+#define MIN_T(type,a,b) (type)__builtin_choose_expr((type)(a) < (type)(b), (a), (b))
+#define MAX_T(type,a,b) (type)__builtin_choose_expr((type)(a) > (type)(b), (a), (b))
 
 #endif /* _LINUX_MINMAX_H */

- The change above requires changing a number of files that were
  previously using their own MIN()/MAX() macros over to using
  min()/max(), as they are passing non-constant values in:

 drivers/gpu/drm/amd/display/dc/core/dc_stream.c             | 12 ++++--------
 .../drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c       |  9 +--------
 .../drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c   |  8 ++------
 .../drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c   |  6 +-----
 .../drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c |  4 ----
 .../drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c |  8 --------
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c                | 13 +++----------
 .../drm/amd/display/dc/dsc/dc_dsc.c                         |  9 +--------
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 13 +++----------
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c         | 11 ++++-------
 drivers/gpu/drm/radeon/evergreen_cs.c                       |  9 ++-------
 drivers/platform/x86/sony-laptop.c                          |  4 ++--
 kernel/trace/preemptirq_delay_test.c                        |  2 +-
 lib/decompress_unlzma.c                                     |  7 ++-----
 14 files changed, 26 insertions(+), 89 deletions(-)

  Changing these is probably a good idea regardless.

- I also tried simplifying __types_ok()  further, which as
  you already  mentioned doesn't easily work with pointer
  arguments. Again we could work around this with a separate
  min_ptr()/max_ptr() helper. I only found 11 files that
  actually compare pointers (on x86/arm/arm64 randconfig):  

 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 2 +-
 crypto/skcipher.c                     | 2 +-
 drivers/gpu/drm/drm_modes.c           | 2 +-
 drivers/infiniband/hw/hfi1/pio_copy.c | 4 ++--
 drivers/irqchip/irq-bcm7120-l2.c      | 2 +-
 drivers/spi/spi-cs42l43.c             | 8 ++++----
 fs/ntfs3/lznt.c                       | 2 +-
 lib/lzo/lzo1x_compress.c              | 2 +-
 mm/kmemleak.c                         | 4 ++--
 mm/percpu.c                           | 2 +-
 net/ceph/osdmap.c                     | 6 +++---
 11 files changed, 25 insertions(+), 18 deletions(-)

 The simpler __types_ok() needs more testing across all
 compiler versions, so that wouldn't be for 6.11 anyway.
 I can send the min_ptr()/max_ptr() stuff anyway if
 you think that's a good idea.  

       Arnd

