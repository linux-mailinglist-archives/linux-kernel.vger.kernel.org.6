Return-Path: <linux-kernel+bounces-170157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB038BD291
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8415282A69
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4860015624B;
	Mon,  6 May 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gUomEPKJ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79677156232
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012600; cv=none; b=EHACw+O4yIZDBPEqKn06i9cDDqs+CCFXNROGZSPx04JgQHEpcguefm4ywpjYGG21oU56rMoxrr5QWKFd1CY/VXQv7Rj3i4f8Hrsa6llnU6CEymIj6WaBBMdSaN3Z0f/1ZFKxRPDmKvTm4/rq88oBy4ldynY4vekAy/LnAoHD1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012600; c=relaxed/simple;
	bh=LmralNm+INcoHI7lRkYYhgaqtwLlW+YAk6+Qe8w60Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfMu+5jx/jk2KaFZRFMBCPw/+Xr1BW/hP5Foue7RzPka6MICESv7k80NMvlERM5KhSsUft4niGOHuyzKH+tJx1jESazn7G31kDPpMcv+WWWIfcSuMI7I9VMbpNCFYcE9pdneVUYnc5KmmTTOSg7vgKEvzp/18eIY5s5FCTZfc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gUomEPKJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so1369309b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715012598; x=1715617398; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ko9WKImq7Hf52RsrSv/3I6aINHKA2FDCht5+ZvEf+MA=;
        b=gUomEPKJ4SYFTitiegRtjuy6AfoMjBU8NzcRcGJiBeqLXinT/Bv8EwoWmblRGLnZs1
         GXYvehrcOg6SPPMtRdL3e7D1xBTYJNOlOk/VcYnJFwA3nPwSSwFLmCVi0egHA/yYPGRz
         w1TdeludKLaC2kwKW3qZaQZAQzlGxa0ZErvvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012598; x=1715617398;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko9WKImq7Hf52RsrSv/3I6aINHKA2FDCht5+ZvEf+MA=;
        b=ut3CA7TXXUXq7n0N4Bv8XPxxufyAFFgZ4IJzFp7u8uNmnA/cqCosnW97VkVkwRcLkm
         k1SEWUV5cyBGE8An8QolbQ43aAa5U6yklYN+/74wcwWpIbz4LC8zyzlkVAJnXI0rCYJy
         iS3hPHGatmVJ439SxNy0npqgTS3iDr8ofVxF9esYl1Dr0/c3Mn+b5P1zKrlodJZaKbfO
         8iV3qrFHfLT8D3A8Uz1j+wCiID4Krb/h+8lYILZv86+e065A1XrRnpXaEqO4Rri+7CHu
         sf6WtexchnKeRogn9LEpo0mn0Lel2JoO7Y5y7XGHlPvwnFoWDJRQdqECT6LOzWnpnwm3
         +3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsZ2ljK1mseK35SC39YekyYQdHJZVYrwpN0rNocKOYMW5a2Bu+8Z9fl9PfTgKy2oxEYZQC/z6vD23W1rOdqzVIKyu9/gWSY72n7fnm
X-Gm-Message-State: AOJu0Yz0I4zuXH6WsJhrN8LPOD1RGq1cKYb/s1IAjOqzI6Nat3+3I8UK
	VkgGOMjwVchT5N7BgNdGdYBVeprAGlRCWoOr5RDKvDnT4A9WX9OI0aZjpelESA==
X-Google-Smtp-Source: AGHT+IHBKdEzGGuJeQi6vNrQbny3eObyZhGrzgxQ5sxwJNu3FZZ7PzBBOuu9uKfhxKRRkHIToQb5DA==
X-Received: by 2002:a05:6a00:885:b0:6f4:179a:fa5 with SMTP id q5-20020a056a00088500b006f4179a0fa5mr12305611pfj.31.1715012597581;
        Mon, 06 May 2024 09:23:17 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b006e6b2ba1577sm7892362pfn.138.2024.05.06.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:23:17 -0700 (PDT)
Date: Mon, 6 May 2024 09:23:15 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID: <202405060856.53AFAE4F22@keescook>
References: <AS8PR02MB7237569E4FBE0B26F62FDFDB8B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <51a49bae-bd91-428e-b476-f862711453a0@wanadoo.fr>
 <AS8PR02MB7237EF9D1962834BE4D2C5F88B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR02MB7237EF9D1962834BE4D2C5F88B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sun, May 05, 2024 at 07:31:24PM +0200, Erick Archer wrote:
> On Sun, May 05, 2024 at 05:24:55PM +0200, Christophe JAILLET wrote:
> > Le 05/05/2024 à 16:15, Erick Archer a écrit :
> > > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > > index 4013408ce012..080537eff69f 100644
> > > --- a/kernel/events/ring_buffer.c
> > > +++ b/kernel/events/ring_buffer.c
> > > @@ -822,9 +822,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
> > >   	unsigned long size;
> > 
> > Hi,
> > 
> > Should size be size_t?
> 
> I'm sorry, but I don't have enough knowledge to answer this question.
> The "size" variable is used as a return value by struct_size and as
> a parameter to the order_base_2() and kzalloc_node() functions.

For Linux, size_t and unsigned long are the same (currently).
Pedantically, yes, this should be size_t, but it's the same.

> [...]
> > 	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);
> >	if (!all_buf)
> >		goto fail_all_buf;
> >
> >	rb->user_page = all_buf;
> >	rb->data_pages[0] = all_buf + PAGE_SIZE;
> >	if (nr_pages) {					<--- here
> >		rb->nr_pages = 1;			<---
> >		rb->page_order = ilog2(nr_pages);
> >	}
> [...]
> I think that we don't need to deal with the "nr_pages = 0" case
> since the flex array will always have a length of one.
> 
> Kees, can you help us with this?

Agh, this code hurt my head for a while.

all_buf contains "nr_pages + 1" pages. all_buf gets attached to
rb->user_page, and then rb->data_pages[0] points to the second page in
all_buf... which means, I guess, that rb->data_pages does only have 1
entry.

However, the nr_pages == 0 case is weird. Currently, data_pages[0] will
still get set (which points ... off the end of all_buf). If we
unconditionally set rb->nr_pages to 1, we're changing the behavior. If
we _don't_ set rb->data_pages[0], we're changing the behavior, but I
think it's an invalid pointer anyway, so this is the safer change to
make. I suspect the right replacement is:


diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4013408ce012..7d638ce76799 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -916,15 +916,11 @@ void rb_free(struct perf_buffer *rb)
 struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 {
 	struct perf_buffer *rb;
-	unsigned long size;
 	void *all_buf;
 	int node;
 
-	size = sizeof(struct perf_buffer);
-	size += sizeof(void *);
-
 	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
-	rb = kzalloc_node(size, GFP_KERNEL, node);
+	rb = kzalloc_node(struct_size(rb, nr_pages, 1), GFP_KERNEL, node);
 	if (!rb)
 		goto fail;
 
@@ -935,9 +931,9 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 		goto fail_all_buf;
 
 	rb->user_page = all_buf;
-	rb->data_pages[0] = all_buf + PAGE_SIZE;
 	if (nr_pages) {
 		rb->nr_pages = 1;
+		rb->data_pages[0] = all_buf + PAGE_SIZE;
 		rb->page_order = ilog2(nr_pages);
 	}
 


Also, why does rb_alloc() take an "int" nr_pages? The only caller has an
unsigned long argument for nr_pages. Nothing checks for >INT_MAX that I
can find.

-- 
Kees Cook

