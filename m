Return-Path: <linux-kernel+bounces-375172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234979A91DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE7C2832F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB9D1E2600;
	Mon, 21 Oct 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMog5VP4"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727601E230B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545306; cv=none; b=FcUFCL/a711uNVNciXWrFcCAyFcY2RT9MBWol8MftPX1AOKz3YyHIw0wzy5+OFyBjLgk86AvLf9jcDfljMV8SzbIhUpLrS7/3f4MvrExM8SmhkEDKgRICxmQ2T9k+jXDRCzkU3x7Y+sU4pWNXXqBcS98Tk82i85t9N72lvzHDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545306; c=relaxed/simple;
	bh=zsJQAafQ40Bys4A9PmDCvG/ffOglcaKW7iuyke7hHI8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BYxYTbQsc4IqMEs8vcu1BqSjQlZs1I2BaZ1u0NA/XzDnncYM2q1kagRKg1ra3QTIHU7/kAkNUMlBL4reKL95rbRiycVf+SnwMaosJvfWXvWTSjdomGrSw+31T5RLA4wUzS4TaHfj4nRjkLBRiU9RZ8USzqTWqJhGqIjH3hiom5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMog5VP4; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e6075cba82so1163731b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729545304; x=1730150104; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pl+1OXeS3jjCVGi9wB4DNdDzJV71eNiyACNOmRjgT+o=;
        b=XMog5VP4fH/0VakoH52Z3f38UvU8vtgFSf+FIITW5u1C953wYwcAxFmqkNhHH5t/j5
         iriAdPgzpWWqtt3xOTNlp0WUW7sjqshprGW/GZ15bPi8Owxa/IbmsOfvBlCNO5MCGXsD
         IejeW48S8hNTG/EJQUjwno1mpclyWKCRq6/uEp+1IS/3hcZwUUerlkS7F9+nvUqk/bNP
         6BItIOoWdNNCuqXYm5RGH+QlHn705qEG2zV1bBV4Fen7EG5VYv2lhxGwgdgmGfJaiXC6
         VzSv9WEnW00IKrrhPgs5mIyuhdMFV9XbP+7jSKoY3iUDY5kRbBfggAxZm8iMp9IXXALz
         2gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545304; x=1730150104;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl+1OXeS3jjCVGi9wB4DNdDzJV71eNiyACNOmRjgT+o=;
        b=ZkUE5+hNum0dtF2wkfdBp4hb9Q/4t9Q5VePiRJuUiu0/E95bUBhYDWj9w9A2Li4OH7
         HLrspIfI7sCVyOzOjSplsPFgu9+jTCOnYzHxure4DktNFUyVULn/eYTjDF5Ks5nD/fWH
         n7RJMfZSRDV4WwX1SKh7m+Csm2U/Iz5TGYryUOlAVtuCjkY7YHjMA8TxozNhUNJSorz3
         X3Wcw2+3GnYmOM9GvXNRvPpB5LDiEUAzkZ5wTNeZRtMPkicCfUTNqqoKZgmEc7tOQ2ES
         cOLE4IzW+9yAOknl6Y8HMW7MY2bMb+iSkhx02yg6CpbFgcHw6O1KG9uZzVTJaNHG61Fe
         N5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCViOadNB/f9VFk4lTwrgAOgGHSalIEC5XgrO2CeLObaNQwOwvF5r/RUkDWdXkbTQ8MX/qQRn9pj++fjHdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMbM7bd2hLM6G8AYbTtJLGQA4BjkQavRaHEMmVYEHoKHCKrpv
	y43QV+UgTjUODQmYcnQ5PBRQmk4iaCb+pX6ra3XxrDlzoiiesOzfMmSlwKWPXg==
X-Google-Smtp-Source: AGHT+IGhmMLh8kMBM7/zn2z4jyFvwJfyOpg4/BrLJOLeBH5m10Rp7qrILHmCRyf0QZdt7co0ILfoug==
X-Received: by 2002:a05:6808:191c:b0:3e5:fd5a:c39b with SMTP id 5614622812f47-3e602c64e79mr10377280b6e.4.1729545304410;
        Mon, 21 Oct 2024 14:15:04 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e610d10207sm878832b6e.53.2024.10.21.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:15:03 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:14:38 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Matthew Wilcox <willy@infradead.org>
cc: Roman Gushchin <roman.gushchin@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
In-Reply-To: <Zxa60Ftbh8eN1MG5@casper.infradead.org>
Message-ID: <5a793bff-acf0-86c4-cf4b-159f176c8103@google.com>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev> <Zxa60Ftbh8eN1MG5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Oct 2024, Matthew Wilcox wrote:
> On Mon, Oct 21, 2024 at 05:34:55PM +0000, Roman Gushchin wrote:
> > Fix it by moving the mlocked flag clearance down to
> > free_page_prepare().
> 
> Urgh, I don't like this new reference to folio in free_pages_prepare().
> It feels like a layering violation.  I'll think about where else we
> could put this.

I'm glad to see that I guessed correctly when preparing my similar patch:
I expected you to feel that way.  The alternative seems to be to bring
back PageMlocked etc, but I thought you'd find that more distasteful.

Hugh

