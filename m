Return-Path: <linux-kernel+bounces-408000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C459C7891
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E832823DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBDF15FD16;
	Wed, 13 Nov 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDyCz8qe"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF37580C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514764; cv=none; b=qchktlB7vD2RxmFxGv6AwBCS3EP5ihMBNZ6Y0C6XRcLYXtt7paU906NkGW9Y6hI59f3ZkaXqVfySuB7NdKQ9keXDwi+h577dndsIPMPkQgIEOyy4yWktRb9iBvhl+ZDVxhgAPP63xJ5Ds3MRJq0o/hdIPd3gpnUjEvT6wKbYBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514764; c=relaxed/simple;
	bh=nQyxwU5QgfGswnw+i5IfFlcaTMTHduoouxVX/8n+73U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LenQHjGBNmZKgsR5I3oohBeKDpgk3XguHRkst9HVe5VSBn4sf1NZQUfRo//+/dczN4GzjqHxlFXmrVWOzpGnU+bSnk4+xfWqENTqwBxeFFLuZhIvDOK2nOedkli+IyfS77oKmVqF6D0Edy0HnZBlI+Af6Mrm2Qq7+HyyDrWG9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDyCz8qe; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460b295b9eeso238001cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731514762; x=1732119562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nQyxwU5QgfGswnw+i5IfFlcaTMTHduoouxVX/8n+73U=;
        b=XDyCz8qeGNYnNP45SnbtyeruA8lGyN5VRU6r0Wda2+It9mcq57tZrcB7eooJwsZi86
         TURvFhZiJ2HXNIgkHJIGic0A+4UxHvkTtwIXtIvcjMkqvp7t1LO68e0rcsbKMrmrbyNl
         UUdnZ8pE6HN/QK3yi4FhdqHJeUBLE8psDHOdXOI7Pt4PsoSo1xeRVezBZYjeTQlCJ7jl
         JMFt6TTA4vH012x5IwyxBMbU1jGXOdrKzEbMIGvy3xcNMdQS0OeIHkAujA+HFZhIR4Cj
         gdZFOR1hzconhD9oEzY4e13qQo32PinzvZXVMx1RgUOH7WKJTYjp8MOAF8XQAF2H2KHf
         3SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731514762; x=1732119562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQyxwU5QgfGswnw+i5IfFlcaTMTHduoouxVX/8n+73U=;
        b=dy6OgRZR6/Wishad9rndogp+Z1KTrtISSo1DJ/d60s8xzCoya5CKu0Ai+Fm3KM0zcS
         N5ghSez0vjG7YFvsj5cDhMtTzz6ydsV7HxzhKff8qFRQXAISt3Bcmsy4aF+SNOFFEIAS
         zABXd1/0UsE+X9QqLvuf2FATAGkoBgQbhenZhdQ9tr16+VNRqNHe/RMwvaO5oiBHOmCZ
         9kKFcFjnT0/g0VEWmQ1iNQkn7fqv5eq7z/ZjiKhb5o6f+FMeoxw//dJsllYTizkM89De
         PbT/WaZLMRCtm9kQ3HTp5zC7cU7ZwEc8+YZcvSfid+p6z5frktt0vAhQJaNUwTNoppFM
         Jv9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7Mrt7rkMNBwvo+DgUObNwL0vSsaSukvTlaP1Piw8MeRAp6peqRxxZ9n05yJTZuqxEmb/HjS4BJE895S4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+sgiHyc8WlAvdGZ6ddXDGEN/JgxnqcKU7j24lsxjsOF+bppD
	8MNQqrzDHapgod6ltr/7B2CCiRZ5nAcUfaKAPiBYWnWvZl6qhT5Vd2+y0nNx5k/qPglo03F57Y8
	syPmWshYuS017FwdYtZXKyRPIMmyAtv9+9PE3
X-Gm-Gg: ASbGncuBEpLCAFcSPPEtHbquWRwIFW0aNdp+y6s+P/jQvtBotk+QqiAJ/vxF5XA6o4Q
	rCnNvfJ1fNTW8pCGL48sQ59V7+7TA7eJQunSMrv31ANdwEjUk8QgUO9b1NyquogSu
X-Google-Smtp-Source: AGHT+IHIDFFlxroCqvlH4RVNE6BpwL2INEGY264/PvCYdMcri5C9Dssgza+g1nj17+KeBBrq5tNvsAiPYpNx/GQ7jDY=
X-Received: by 2002:a05:622a:4e8b:b0:460:e2d9:b745 with SMTP id
 d75a77b69052e-4634ca2ad70mr3065251cf.3.1731514762234; Wed, 13 Nov 2024
 08:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com>
 <f3ddabdc-39fa-45fa-97fd-d8508c2229c9@amazon.com> <CA+i-1C1zN_GcLagTRgfJqT6uFoZaMZj1NUfxkvP7eG=VGQ0GGQ@mail.gmail.com>
 <LV3PR12MB926503BA63C616562E508D8C945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <CA+i-1C2JXYUBnE7fn6df0=KR4KeD0VgwO5Cc2xRhO8rBqC_p+Q@mail.gmail.com> <LV3PR12MB92653337C2377D640BF81F84945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
In-Reply-To: <LV3PR12MB92653337C2377D640BF81F84945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 13 Nov 2024 17:19:11 +0100
Message-ID: <CA+i-1C2mJYwQYF9WrCjBTO0rfyNtDW=r8ZTpMwySrKSniVtXSg@mail.gmail.com>
Subject: Re: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: "Manwaring, Derek" <derekmn@amazon.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"x86@kernel.org" <x86@kernel.org>, "mlipp@amazon.at" <mlipp@amazon.at>, 
	"canellac@amazon.at" <canellac@amazon.at>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 17:00, Kaplan, David <David.Kaplan@amd.com> wrote:
> I wonder what would happen if there was a mitigation that was required when switching to another guest, but not to the broader host address space.

This is already the case for the mitigations that "go the other way":
IBPB protects the incoming domain from the outgoing one, but L1D flush
protects the outgoing from the incoming. So when you exit to the
unrestricted address space it never makes sense to flush L1D (everyone
trusts the kernel) but e.g. guest->guest still needs one.

> that may not be covered by asi_exit.

That's right, these other mitigations are part of asi_enter.

