Return-Path: <linux-kernel+bounces-425979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0371B9DED3E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C435282487
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2F11A08C1;
	Fri, 29 Nov 2024 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cYEAoFVA"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1AC54279
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732919403; cv=none; b=K88hasBlwe5GxH47bpock3LIXiXRuYRXV8q41YrZGBXLZo0LyLY9ZHpeuSGliNOSNzlokcAmpFE6TbbdlgC5iV2xvO/ZVrLThg4GYWhGS7nMIEnIamw3YNuy7mYxJ6N8iCKb0+sZOr7OWvpUdsCk+PDzsW6qJocgiou8Mczhodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732919403; c=relaxed/simple;
	bh=US4amykFr5ddVKxjiqf9qV7P1EFpR8NMhdlERjZso+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcB1wKR/pvDPQUEr25USn8QDHitI3xqmG6qA8L8V+PGrlsHf2F49y1h5T4Ki+byjva79JoNRGrBY0Vs61Xd2SqEfP5ah8lwz98co+QmXJAvKIKtb4FRHjrJ9OFN8HL0lZ7qFIy3Crh4aCevk2ZadibuJat0jid16hDvnw1FNbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cYEAoFVA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so419046266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732919400; x=1733524200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqk8vkSIGyKesedtaum1t29b3vRP4R5QQLHeiE2zpek=;
        b=cYEAoFVAoqxdiCPSyhaqHPdnB3i2AHNJAhHmgMK23K+lENosGfFjRnFF8S1Dm3kY18
         hq3VWUCiiZ+PsE6/rdL9vRZRqio1chzabuUFl7SfY2MCe/vpu4r5GXBBa48NOflbMzqE
         8J/at3EN44E8LcasKrpuf9Nzr6HGNYSR3P2V1HroGkcnSO3yjQRgVce7h9B+Gg/I8+CY
         Xcn5ntftO1ReNVjoeczMvvPd+hcvfBLIBZ0ucAd2TBmdMPTqEQ7gtipuOBazEZwyyiEE
         5Zv/O6z/YUJqo5U5Ja08ZC+jen910T3k0xVT0cq9ckLQUsgLZjm/Re1ACkmGoaSeXlYp
         n5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732919400; x=1733524200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hqk8vkSIGyKesedtaum1t29b3vRP4R5QQLHeiE2zpek=;
        b=rpWeGr8S1hIIkWFXoOmLoFAIJfGZS4vQFVzqpcKZNd+whrE3wE+tW9wFs9VO0kpP6Z
         qCk3mc9nNJCU/Nt+Ri3b0mMzWbThjIW8awMQm7/seh3NG1A9OTCAty6Q8Amt63P6Pz9q
         YSNzd8tz+Vsx5Adpsy+2mn8KcJJc2dkGyUeCSfhurMLycOFQ1GsNxUw24qDpqUg3SFMW
         penINTaiul8t/qIu6wk1AfREZwtNHXvY5VPBbA4GP6BRNaBfLN0hy5H1jkdrrRwYSTru
         DymCcre6I9u97x14wg4F5SSGyvhvJwNXbKiGyhnDCROBhJc997zwMQR9NMbWUTGfJtN3
         DjGw==
X-Forwarded-Encrypted: i=1; AJvYcCVgEQYchhELWnjtwykv6kMC53JpQWCj8tn25SDBqVzQ3bJp70YmhTTxd6ZH6YrmllTVY6n7iKsoApeobqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGKVtHJrAJwLPlXDHFowKY5nNNP8xCiglsnhD3zXTEQnX9/JE
	/ngu97pgxpc9BKjJUNZfbeI0+czb7MTWJsuShdGWsi6D2ty4mLeIMyi3DjuR+dmesY5yj32fs7h
	itTzTHSGaoaC1sUpdSRVSXMovlU2WtR/l3t2D4Q==
X-Gm-Gg: ASbGncvhK6IIf6t3iTaMwkvi9htjeD0zCSKLy4zoNNWnvjf6el1/QkKmjwS1+jMnot4
	bNY5Ubkc79lNBTYrK56cK/dftCpGhImjvepaE5XiU4GVNTph+48w+0p/wEf+6
X-Google-Smtp-Source: AGHT+IGD6U3oaxtSMZQVfdy9TFXf1JM6pq//zBUlUW4tdizRmZ1hS6c7zHoDGfiwaAYKXgF9d5AcGO7Xuq+LWbOYwC4=
X-Received: by 2002:a17:906:4c2:b0:aa2:c98:a078 with SMTP id
 a640c23a62f3a-aa581076b06mr1442894966b.57.1732919400359; Fri, 29 Nov 2024
 14:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk>
In-Reply-To: <3990750.1732884087@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Nov 2024 23:29:49 +0100
Message-ID: <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 1:41=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Could you try:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dnetfs-writeback
>
> I think the patches there should fix it.

I have encountered multiple hangs with that branch; for example:

 [<0>] folio_wait_private_2_killable+0xfb/0x180
 [<0>] netfs_write_begin+0xe0/0x450
 [<0>] ceph_write_begin+0x27/0x50
 [<0>] generic_perform_write+0xcd/0x280
 [<0>] ceph_write_iter+0x4d9/0x640
 [<0>] iter_file_splice_write+0x308/0x550
 [<0>] splice_file_range_actor+0x29/0x40
 [<0>] splice_direct_to_actor+0xee/0x270
 [<0>] splice_file_range+0x80/0xc0
 [<0>] ceph_copy_file_range+0xb5/0x5b0
 [<0>] vfs_copy_file_range+0x320/0x5b0
 [<0>] __x64_sys_copy_file_range+0xef/0x200
 [<0>] do_syscall_64+0x64/0x100
 [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

I can't be 100% sure if this was caused by your branch or if this is
just another 6.12 regression, but I haven't seen this with 6.11.

