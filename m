Return-Path: <linux-kernel+bounces-552211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E363BA576FD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22660175265
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DBDE545;
	Sat,  8 Mar 2025 00:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJL9f+DF"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552877482;
	Sat,  8 Mar 2025 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741394434; cv=none; b=S6dsBMOQy9XarXKMhuRWy8weYpNZkxTMSXLThI4vtWoI0CDd/dVn9/UXMtgiTe+Xg0PaZilCtVTBCIpJ3xmgtNhareTiYwqm23AniNyumJY+nHQCMHmyNYnL3n/LLkoFzALNR/gmUl5QruUVjniwiaTt4Z+UAEg0D0tQooP9mJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741394434; c=relaxed/simple;
	bh=kt+JCm+8BOZiygO6UteY2W7IJhPNVbKC6fyeCRhPqy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SRQWtfOGMMSSMy24J8E8QIntBxVf+3bg+O9TZaPOFXyuV0QIT4kg7VLgjnT3BAvLZa+Y+GrQypbnXPS0ltn4l7h0ZrV5TUXa8hbT/Qz49QDh8ZzTg0bUpl2JKm5rjhCUy7ACoLBNaKzLL5ooNlc1Qm6UdRT/Lvnk8Euubg7J/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJL9f+DF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2243803b776so19994635ad.0;
        Fri, 07 Mar 2025 16:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741394432; x=1741999232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRQ6v/k8DpVkHkERpfwwUWy2zkLZRvPHoToTH5G6TDE=;
        b=mJL9f+DFu4LZttNi/HqVTxdWtrkHpPBTPyc5JwpYx7WcwMajyiht5H5uwmgKy4g+pI
         trET8LlzVkwp09TqtrlxRxA+Avd89v+hqsfPRA5IJMVkodejpjHMG61EeUZZqc9BJ0Z8
         fvzMWBg+Pt6cdqJcb++Mc4obMlniCg9ScN+QUzjJpXPcEkGptqDaPVX3lcXE6Sb/E8LT
         A13mc7Az6KFvQaenwlPUHFADzmIRxQJDRYc+OLiRn6H23bMJaugPUcCZNgZU95z1+2oz
         xE4kzy+VlzYAj5bgQSQScZK5/hKrskvylioTXH/KZCx3nk6+sQFPt0WbKrk7ET0kTNpB
         Mjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741394432; x=1741999232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRQ6v/k8DpVkHkERpfwwUWy2zkLZRvPHoToTH5G6TDE=;
        b=N49bYCDwQd/RJhX+s4Xsn5+YozuZPD1ymxMaj0eNqKlNcVx20Ubu4Ddz2vaIjw7VY9
         PZYMlYuu6WDAkImFBVPnOtTb7AQF9/NkYgjjppnWejGSVdFNnEpOqAdcyPsa9RlvtzTM
         xTMmwMhJbBR6Uc5ihkExyfvIbOmt8IwRvXNHUT28e+Bx0mJp1OR1ICcj55j2EP0dZD8+
         caXuqyp39mpdd0nHMcEr25kWYrMaBZntJ8sFRUW+P9MrSjetJWm5ap+T8CxF8bSnOdp1
         ho0WURgArZns3B7SE4cooNyiuJtYEmFfcoUVqmcg3pG4SOoGR120mvVoX4/wT5AWQeCj
         1OfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFeXKMuGO24eL8/7SaixGl6jQpoYZTlcz1lLzWcRyN1c7loFjHCKE1bHcJQtfDuwA2PerNALjjDD161Hs=@vger.kernel.org, AJvYcCWFeh4skjaPmm+Bs2FKvClPTAT6nc2Q/54/POc8D+cEAksr0t/GAqa31aeB5Z5lVJjjYCVd7mZYmBwOV7WaWNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrn7UnHVJwdbR6pCGMSilnz09CAsjJ/FjcJVVW2nWwblavRLq
	bjJ/ISxiHXfyztUCBDHhxX/E7QyByRt+qdqCF0xt8RKcDL/adv6r
X-Gm-Gg: ASbGncvjZR/ega/3Nk3myTC5FRyvqC3hbwI85ro0TE2r4KZ4pKE9y7iGjyfUkp3wV2c
	dAHWwF4XLhisBmqikPwjwTaU8uNhAQ68D7xw6REttRN7XPujOXbmHgk3K9S3kISk2Ofr9UR6J1e
	znEb5jq/B2AhfxtWdAyOl/KO/LG0QFn7tdpMNzpv2m0KbdVmk4NrSf4NggZTdIxIDZIyP9RR8W0
	V1UwdUvqkzBAY98ylAzUK6CWT5NvWR6Lecy9mRjXhfW/GUr1wtrqHkkfQz+97zMQikedxZTYoB1
	VLsqhXw8yld0uPH6KXVjHfnWfBkiUjcJIfk23Dka3BGrRUV30mZK
X-Google-Smtp-Source: AGHT+IFgmSNYV5rsySuMDMWpg9hgb/exgHmxSmtu68SfGY+rRFmaSLERbV5REM8iPDlVHcG31yn6RQ==
X-Received: by 2002:a17:903:192:b0:21f:35fd:1b6c with SMTP id d9443c01a7336-22428ad1c13mr79381015ad.45.1741394432390;
        Fri, 07 Mar 2025 16:40:32 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ade82020sm2121120b3a.17.2025.03.07.16.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 16:40:32 -0800 (PST)
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
	charmitro@posteo.net,
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
Subject: Re: [PATCH V7 1/2] rust: module: change author to an array
Date: Fri,  7 Mar 2025 21:40:19 -0300
Message-Id: <20250308004019.655958-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72mWBrHpv9XYcBbVsJkhH9SzM9N4fcL2SqoNQ9X-4GiZbw@mail.gmail.com>
References: <CANiq72mWBrHpv9XYcBbVsJkhH9SzM9N4fcL2SqoNQ9X-4GiZbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> In general, if it is the last version, you don't need to pick up tags
> -- maintainers will do that for you.
> 
> i.e. in this case, it would have been fine telling Alice that you
> didn't change anything (if that is the case -- is it?)
Yes, this is the case, didn't change anything in this V8 in the rust side
Well, now I already add the reviewers tag, I think that is not a problmem here,
right?

Thanks,
Guilherme

