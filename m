Return-Path: <linux-kernel+bounces-378594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1059AD2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1130285D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259061CF5C7;
	Wed, 23 Oct 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="EnZu6QES"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012C1CCED2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704401; cv=none; b=U4k0waGbkzP8vO9ZvURdk0mOsp8dYHTIO43u5BeCOANTFaA+NLtT8w1OCinGhSROZnfGEXmAg2DYfLuZtFQ8LqGAS77QsGm21j+SME/QKjpqGclFj1qMT3kNOScHr/vduIaDw6PVdAI8YfZAu+3TmpVIel6MThdEQQcimt4otII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704401; c=relaxed/simple;
	bh=AWFBW7FfgrM+D0zC+8M4nTbfzWykLXKE0+MpT5ILXww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoPJI+W54UaatpLQtP+o+ACkWvbPNwBK+4h9EFbte+IIqQI/543xNMG90RWg5C+C5G+VQxlHolC8/1ZWMFxXY8Z6PmFYkiw0ddUKTeUU4xeGws4LwyHwvJwQ6aDCPC5miZm8jBh74tGPs/yz0msJKHFeXhy6i3aVT8Fq1VRK6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=EnZu6QES; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e606cba08eso90517b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729704398; x=1730309198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWFBW7FfgrM+D0zC+8M4nTbfzWykLXKE0+MpT5ILXww=;
        b=EnZu6QESoIdhW8vlu4RqzQbCSGfT6mqSvKiUVX/7AbTn/7Qn7jmPyu2tR65YwQiZ0n
         vpxclIUM5l6EpwBi8OM6lAaJ59EzLVTJmhwUhdNTUtXovMg/6k9uK1ODp68YEdnMLH94
         e1J1Nw98Svz6TUev/GE0LX/rUcLlErJ0kZ5FU6xvsARVRb8z0zDhEDD8+HFw73lXdaQ7
         BzlMdN6VCfaOrxWGUWdu58cHikN3Rd9EpfzZ6jIo1cPV3mN6e26bEymqFleDDdAQTCRX
         ggUOaNqw3z7XO0eC8hzToHqUTdqAsCXhkSlKZ94E7guFlVlrMASXmklyjUcl7SYUDDie
         0h+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704398; x=1730309198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWFBW7FfgrM+D0zC+8M4nTbfzWykLXKE0+MpT5ILXww=;
        b=Ldi81lH21Wu2gG+I+mJNSqGy/pOg3r7zpJe6zr5kiq47XEUIj51gre0THOSi9e4IIH
         jH4IWFW6YYApZTg1ey8TuTW7obdisSjQp227sMANP8B9wHAfV8W3gOcANmmdJwnT/O+x
         A1YGVaP9ypkNnnhWg+mGp7IZSLAMqdCkA+mhiyWmHTKUkqbl0z7Ff7vb99hhxZs+tbRK
         ipNK/sFXHYQ99UQSJMOvNZuiPYEK+ejmG9eqrJd5zAteSRWGufvDbuh3JpchU62DbE8i
         9gnJQoy/1NcqxeUzq5KxptHhGir0Skl7AXjBqn+fCHFVsoZ8fcDSmRviJed9ux1tdbx9
         HBkg==
X-Forwarded-Encrypted: i=1; AJvYcCXY6WF9BWDYmBUohCj/1WNjhU9SoT3eER45nll9dVQIMccEXBJTEhTY3s9XDiuhxk9Q853OI7ZWga/pQdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv91B7x0KeD5dyVnZdgG0BW/ozKYNrlYBYn2O6DsqWHQojSevR
	+wJZjDTy35ktwvOslelFS5GZB7DS5LkfoeTHS5zD2y68dp8n5IwpU9Dq33GJYrqnkEL9dNGyvZA
	qrkQtB/5c5wm5IsqW2jXr+hL+aq6+gVKvEs80fQ==
X-Google-Smtp-Source: AGHT+IGckBdU29o3tk+wYPFoKwsMk5i6ERT8sORHYNIiU6+p/6iCZVXQYympbyvyWVcQV7nCYD9zoCsM5F2gZ83otEQ=
X-Received: by 2002:a05:6808:3991:b0:3e6:23fb:b391 with SMTP id
 5614622812f47-3e6244eb667mr3799063b6e.2.1729704398543; Wed, 23 Oct 2024
 10:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-3-surenb@google.com>
In-Reply-To: <20241023170759.999909-3-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 13:26:01 -0400
Message-ID: <CA+CK2bAZ4K+1ZZyFwwZ43Q9SMPzSr=9r=OvqjNK16Ai3E92jtg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] alloc_tag: introduce shutdown_mem_profiling helper function
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Implement a helper function to disable memory allocation profiling and
> use it when creation of /proc/allocinfo fails.
> Ensure /proc/allocinfo does not get created when memory allocation
> profiling is disabled.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

