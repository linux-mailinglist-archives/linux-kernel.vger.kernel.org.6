Return-Path: <linux-kernel+bounces-550126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA824A55B9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAC97A45ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719854C96;
	Fri,  7 Mar 2025 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8Sa4cR7"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F818CBFB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306384; cv=none; b=SQskRyRaNqEeiyk/jHTq+l63aPZ4m+taLH471ajJoQSZqLlLEOa8Y9TJv+/oRnJyFtbyEbJRO5KmruA6RwuoaZrssUQyO7mOH877Gv5ytsDXocNiLCad3AYlAu/+Loc96mspqIKIXUvFFbaECHaYjYF/YAQqeEK8PbVd5lUc810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306384; c=relaxed/simple;
	bh=Tenu1ukjY6u+ZkLVEiCAKDnTnxufajsrpXcE5yWz9kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaCd2um2UAaOaWr5ukzHaXfA0IfXh4wHphzVxy3XUT9vPeUx012WhjKd/Febh3ieX4kqHnspQIR5C7MRpfNu34TwDnIcbpMTNDzchzWYWtX7wwD9vBxC0F9L1X4s1yxlugOaU9JiJvsD95gl7iXixAzJk4y9bkvAhRCpLmS/2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8Sa4cR7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240aad70f2so73835ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 16:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741306382; x=1741911182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNup9EWbC6i8Ta60udEbTUwEbnvvutxKgGcyMFVFThM=;
        b=o8Sa4cR7kqg8BtBRZMbK/EwaVXRDb+4/AQgJsisqokyKRSdBoNzlRA14qjP7yUig+1
         NdXnx2CQb9CrZFwQuup8cZrMO4BY2LLiE9rzB5Cz2KwIPPK0xquaBPXRUPIHUIuvy5em
         Tk65EDJzOvJF0PtsaPx0LdECH1VJK8DwYyu5dm3Wl1b5hhI5yC8rm7atRtS8DGoOk3a9
         3CaAhX74mMWgw59Pom8R5tyBGXy/qYgY40FNt1o2MvCwLZGh9BLZweHuZTfqevxHaAvI
         gCdAC1smToYk3Jop/J5rYBlvZC6gu6cwm+rE1qhPTOq/sBzpNVQkqr7e4baEGq4XRoga
         o2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741306382; x=1741911182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNup9EWbC6i8Ta60udEbTUwEbnvvutxKgGcyMFVFThM=;
        b=jKhxup0go3sTSTCBH7K2JWRtWwAWYLqEuIugzVTBlBzHwe+yhh/ldc6xQXqPoLjrPx
         fMRtDDRjijFsnv/LlwShEn+xd1tatHS3P6j/CKBVuhBywKe3Oh7m+fhi7cXHMS8NoP0T
         jMdkoZrUXAwpC/b22PraUOUqTdJe0rTu1lVbTxMV+cc5FhaAHBkvNXE+FnvO0qcsRJ17
         b5K5euyC8wTwLJG0p0BkD8DbKOjMI5DQJ/4BD21CdcRhLzsl9z9m1qxIpPr6iQNornHR
         aoEnOIe7WcM8t+oM/yI1AKRs7OuvvdziCNDJcDeiMUqGkHYwfc1zeZPD7QwoUDz9XWzm
         8Aow==
X-Forwarded-Encrypted: i=1; AJvYcCV9oZw7amPoqsK+rBRSPkKw+byC0bju1YJtzeAJz7wj26Rz7kSTpd47XV28jS4vycUTpH+E0jlYjKXTLCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGuGeK1j8Yew8bcTQhidKw6dloc3/Fk6bAy37NT29s+uba7xGs
	WZm5O0/ZpSjvHQkyJYgjgALAUHQZdRbbUbfa2hj2KSx5N9TBoE4+hqu8VeT9Lg==
X-Gm-Gg: ASbGncta9SO8jI3UtZqVXB3VS4gt09vZK/tn0jIFOK04DM1l+4FE/jroxbLSLHCm62S
	yc0GGEYn0COX8iG0IvQerAK8FiCJnH+Kx/OjCNgicpLXqOiy9Ug0D73v3x2KzuYVSSEwToBPXFr
	SQjFI03k30toRueCK71C2EnuV1ZE4gP1wUu/5yjzHj61vI+OzV1SrlV8fYbmn0Zt9FMxX7HyCCy
	oXAmgx6dEXQ0ZV+AT4XsC/wNJDM9t+qgHhoxSrfYM0eczMM9Kvz1l9gr1VHAn55oJ7KyMU6NXF/
	Ck4XzN92jjjERTihiZTt+a2zCCC+gvaeY3ZA//e2awwTZYZbK2yKwvlXe0o8o+HIM4t60tAns9W
	IXRqZGvTTtmQFGpc=
X-Google-Smtp-Source: AGHT+IGndUGgbQJfPfDEt+Vg5y1zSKAlbfktDO3mZC256dapXXCz6DYdZT7vrdjQcup5ZikrLodZnw==
X-Received: by 2002:a17:903:22c8:b0:215:65f3:27ef with SMTP id d9443c01a7336-2242971d35amr1149525ad.12.1741306382090;
        Thu, 06 Mar 2025 16:13:02 -0800 (PST)
Received: from google.com (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693f7cebsm1864500a91.45.2025.03.06.16.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 16:13:01 -0800 (PST)
Date: Fri, 7 Mar 2025 00:12:56 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] module: Make .static_call_sites read-only after
 init
Message-ID: <20250307001256.GA2276503@google.com>
References: <20250306131430.7016-1-petr.pavlu@suse.com>
 <20250306131430.7016-4-petr.pavlu@suse.com>
 <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <481a3ef9-6d4e-4e29-9d50-a6338604c873@csgroup.eu>

On Thu, Mar 06, 2025 at 06:28:58PM +0100, Christophe Leroy wrote:
> 
> 
> Le 06/03/2025 à 14:13, Petr Pavlu a écrit :
> > Section .static_call_sites holds data structures that need to be sorted and
> > processed only at module load time. This initial processing happens in
> > static_call_add_module(), which is invoked as a callback to the
> > MODULE_STATE_COMING notification from prepare_coming_module().
> > 
> > The section is never modified afterwards. Make it therefore read-only after
> > module initialization to avoid any (non-)accidental modifications.
> 
> Maybe this suggestion is stupid, I didn't investigate the feasability but:
> why don't we group everything that is ro_after_init in a single section just
> like we do in vmlinux ? That would avoid having to add every new possible
> section in the C code.
> 
> Like we have in asm-generic/vmlinux.lds.h:
> 
> #define RO_AFTER_INIT_DATA						\
> 	. = ALIGN(8);							\
> 	__start_ro_after_init = .;					\
> 	*(.data..ro_after_init)						\
> 	JUMP_TABLE_DATA							\
> 	STATIC_CALL_DATA						\
> 	__end_ro_after_init = .;

I like this idea. Grouping the sections in the module linker script
feels cleaner than having an array of section names in the code. To be
fair, I think this code predates v5.10, where scripts/module.lds.S was
first added.

Sami

