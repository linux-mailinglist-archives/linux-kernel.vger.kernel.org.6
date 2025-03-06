Return-Path: <linux-kernel+bounces-549339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4559FA55167
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9B8166F69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95280215F4A;
	Thu,  6 Mar 2025 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr20CbOT"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C15140E3C;
	Thu,  6 Mar 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278741; cv=none; b=mqcjduA/CkySmBGoAbpPtfEhk8bR1qRhLFiRjjmIaXqz0mygxdi7Qnxo5ZJTMx8na3vK0LCM6x1Nwv9/7cdBqf/M4XWANxy1SG5AIpmJS9/oL1ObG5ZjTx6eXokRPdd11cTk2rHlvKlwdrxbKuw97CIV+kmIgvna9FFjwCF8eqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278741; c=relaxed/simple;
	bh=Lf0XMvKSXUbA6Xpo6sQO8rExp4s5De0XjYlg4XDhGrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiDJ1ZOP9p2Drct/zSDPk4xSdAglrBPgnoXpyJO15sQCRFrFxku5+tkRE3pnntjbFS2A5YkLhHV9T6rYXP6HKNB9m5WZ8B1nG18HDveo/pJ8Dr3jQamoHAayf2zjUpRgmASU8stT9U4N4ZZH40TK7yfbel4sUz1YMiFAI4NRlRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr20CbOT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2234e4b079cso16288575ad.1;
        Thu, 06 Mar 2025 08:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278738; x=1741883538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHnAvxCvcSxijhneF+GKccoEeCeoIo7WaQZF1lh7FwU=;
        b=Qr20CbOT7MKYDJPDBiZ50DzdhJuUPwooMnmTXJTWUaZxmQIam7ZRdntcUqeE5IGr9q
         cNqaFrFVrHlY/egF6sV/p8ez5MOUBv+ayZx3UJyVDIIeQpSsKY8Dtg+/rkhcGvSlSlHO
         rMgHyMzn8v1Estj49gp0PTxYKIr9ZHTb7k24EIQ20wMIdJxr4rLKXiNx+7i9tMcx/lBH
         VM8EELqEQXIoGPZZnwUoHsdW49WK6a80/wsf2LTmQLQhQB5DZ0o2R2fnKmmiOgal5sBR
         jz1ARvPH8tJJQ8TsC5X+/g7L4a7RFAy5L5H1mtY9m1WIuqWtbS3Xlk41JARHFJkgmqjO
         3p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278738; x=1741883538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHnAvxCvcSxijhneF+GKccoEeCeoIo7WaQZF1lh7FwU=;
        b=hsO6km29CWCyrZBoqCXRjbmGjS1ZuARMts4JKuD67kUisSQ1P2+kgCOAXXSQ0MFAcg
         2xEsuTF/PgGGoieetq5jDjeFh4PZYBra+6xD9IuEib87HUkabRQsLlKxDDiGkx2Z2GdW
         VhyKrI5LLHcdnp4BB2tJBzzmQlvxWCZfveBgtN2EszNvazDR19NcFHOmcWWRCE1T+QwA
         2JQ6uV+YUtioZDAik1noqsCqfmqF0kbtEttd4gu7LUXQhZHC/HDgqCUpU30jRsCk9lwm
         41DKjkMxYlOPEaGbB5E7+TS4a5+/850Yte/EH1pujDWAvjUZpInJA4lqD9KmrcHji20q
         hw/g==
X-Forwarded-Encrypted: i=1; AJvYcCUGjyNPCj8IvS6tTA95jpajGbLmLUDUnP7ZKNnxbxLlOWbCNVedlS3rl9wi2mTXqOMEGAaLayOxCcQemYo=@vger.kernel.org, AJvYcCUbgK2jfPEoAy1a8V8eT5yKS2i0NK+xH7NeWhlJ9/zeuoKD2TnWDXhvSpnl27DBKYW8WIEg3ZEdsv1hSF0d790=@vger.kernel.org
X-Gm-Message-State: AOJu0YygcBhlz5YwCQWDjLGcyHZRCk2AW2nwUm+HSnVqoMmKvUinh45d
	IRGNHtmNYxtohDXcTRdGZr2zWRy20dfl5dd8i3QBJS8BklNT3KhO
X-Gm-Gg: ASbGncuoo6MH4hdwDjITzBgVtcuf4i4mSPSKPer+b9dE8QxZz5sa5kaEBccTPv9MBc3
	3V8CS82m7TT8PelEpemr+Pys1FWtEDO51nYiaAr85BwfnWe867qNzl7aGsISY7dnEH30yT6niDF
	Ch4OQiazlT2wYCtyL0SIlPo2XEblvXAH9cKfn0opAi29hN6Fuo8vuYhwMQuvvK+uSEDsQo9KcGc
	O91pHdTgy49d/8/t4pjA7cL1FQWZKqXG25sVdDZGk9fqsvuMFJCEZ+jRTcNg75Apb/tQNobX88j
	JQ0sHSgSbCar4Yb6PyuFeAjlKDF2mnbf548BbYBQXpUDzyTYn/Kw
X-Google-Smtp-Source: AGHT+IGka22YEu+Doguh/8wGA9A/Jlv9zAqqIE6fiQS3/ovFacDbdxllhUkxT1xEMpKYngIi+sfhAA==
X-Received: by 2002:a05:6a00:84a:b0:732:2170:b68b with SMTP id d2e1a72fcca58-736829d2708mr12455215b3a.0.1741278737750;
        Thu, 06 Mar 2025 08:32:17 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736985388fesm1600033b3a.177.2025.03.06.08.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:32:17 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
Date: Thu,  6 Mar 2025 13:32:06 -0300
Message-Id: <20250306163206.301564-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72md_orajH_TREr=ng8Y=o3Xkgw-V5oxbX8vYXOE2UDNaQ@mail.gmail.com>
References: <CANiq72md_orajH_TREr=ng8Y=o3Xkgw-V5oxbX8vYXOE2UDNaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> In any case, landing checks here is fine (as long as Joe et al.
> agree), they can be moved or removed later if needed.
The only thing bad in this check, is when the array is very very big, like:
    authors: [ 
        "author_1"
        "author_2"
        "author_3"
        "author_4"
        "author_5"
        "author_6"
        "author_8"        
		"author_9" 
        "author_10" 
        "author_11" 
        "author_12" 
        "author_13" 
        "author_14" 
        "author_15" 
        "author_16" 
        "author_17" 
    ],


if I set a new author_18, the diff will be:
         "author_15" 
         "author_16" 
         "author_17" 
+        "author_18" 
     ],
And, in this case, if I make a wrong change, like:

         "author_15" 
         "author_16" 
         "author_17" 
+        "author_18" , "author_19"
     ],
the checkpatch don't will throw a warning message, because, he don't can
perceive that he is within of array of author, firmware or alias of module!. 

I couldn't do a better check for this.. 

thoughs? 

Thanks,
Guilherme

