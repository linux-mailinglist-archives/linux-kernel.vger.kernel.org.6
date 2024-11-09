Return-Path: <linux-kernel+bounces-402978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68D9C2F2E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6BD1F214C0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3593E4086A;
	Sat,  9 Nov 2024 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKngsZY3"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9113D502
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731177387; cv=none; b=qilYx6Hz2sO/YWlHc0BikyYyeUmtRSn0Isho7yCq9YbPVetoivz/Kennkyv4AXSjps7wW1qD61OnEP7qwY0KkrNKAgqZYp+D0ue9q51lbl4MRIozyudGnU5qTW0FsHvVGom9Tq52Rlx/e7DrmvP+dkdUDFDTCxoxn4j9xCbrBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731177387; c=relaxed/simple;
	bh=UeuRoLIoFZl+e2wEIDEgVc4qMkCvGPRDAibgJq60uZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kAUlgQOlKX8D1ptQjH3gLxp1txhYPulynKsvBI3+ZWuHXNUYonILCFhii3ZB0e/kNnSpEUvsRzrbY6TKOLv+V/qtyS04rCfjy4CQ8WiTPumGojIXxuM6QwS9A/TU290NCsIgcRpl9cJIp0C6WGJWtP6c2sDjQJpo/0JjdpB+vJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKngsZY3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32b43e053so43509857b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 10:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731177385; x=1731782185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IC0td1EB33f7rDp53a5h8SQVwqUp/0C6lqTv8T24vkU=;
        b=uKngsZY3/j3zfZEintXnRY2BhUbY7cXqBiFOB1Dx0g1ROAkrEG4pI2e+1O946dToyt
         DV4pKLJT3KzcDagmP3zELxVIilZOnftLR806VVjQYWv6btAcgmFBKMmJgOTYZffYhV8M
         r3BJHwUwEbtjL/dfrmWSC6pOBRUJd1PFZWVaFU2CYJQZj9+mRuO4IrYff4YcITm48C2/
         WAfnlI7zFJFOFw8dxhW067wmO9YARcxAViwVBlQSENh3LyIp7v1LEJRvViqvsMh3uOs6
         ER8dMVnm1VdO9//FFfznHUShkm33fmmyvCVYPb+WQbQS3NE6Rpf3L79Spl01MP2tWKY6
         JXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731177385; x=1731782185;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IC0td1EB33f7rDp53a5h8SQVwqUp/0C6lqTv8T24vkU=;
        b=CeD3FQ56jcuGockz4BJilQnPlbZcqhUPP0bK/3kfJYO9TOriVPOCwWYikhnjk06yOe
         omum1ktbzTy+HZEqvPy6Nuyz9qrq5cNVvEKMBl1zILCaEVrctDg1c2k4QNX4se7ZYoUV
         hXfr2PBbFjgNGtTAZnLvZ+X8eyA2c+ZtzbJyBkVfC1bZjHUwtKPYAkmQUT/n0uqnqyPV
         vFLspeLHoi/mYrkzHhFNxe1YhVgptWyr34KNYvjymm2hJJMxODaelyRiD0Zcn0PAnxZt
         4OQhJT7RnT5WsDPojdy0XIICyzQvJtpn5RoAEvxKNvTEqvZhfwSVwPlMzskY0qTtJykg
         D48g==
X-Forwarded-Encrypted: i=1; AJvYcCU2L/y5EUjNnoZqRZgILYFYPS9HJ8V1/gcVVJSa3d6raLvfFTu9OqIQh2MuY3soewDwry6wggvbFn0YQTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jVQSIRj9MLK8G3lcPNqp2KC5y0mDO5wgJEGP6TCxbNNyJ0sv
	3KMzkZ6fun5iWe09dKwxPq69PGx84aEsD3xerWKsYhRzdCUs4sG4KhTqE9VAvh3zMUfpcTk5zE0
	hDA==
X-Google-Smtp-Source: AGHT+IEb4fEPLeJ7n98PcRJUUQ/Ryt+KSVEtHCIMAt5JF3ABfkoP4DvEHRPRh2r9ehSppb5iSvQtA/w7EaU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:3409:b0:6e3:19d7:382a with SMTP id
 00721157ae682-6eaddd71c24mr310157b3.1.1731177385230; Sat, 09 Nov 2024
 10:36:25 -0800 (PST)
Date: Sat, 9 Nov 2024 19:36:23 +0100
In-Reply-To: <20241109.xie6Quae9chi@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109110856.222842-1-mic@digikod.net> <20241109110856.222842-2-mic@digikod.net>
 <20241109.xie6Quae9chi@digikod.net>
Message-ID: <Zy-rpxay3VmM7QuG@google.com>
Subject: Re: [PATCH v4 1/3] landlock: Refactor filesystem access mask management
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 12:14:49PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Sat, Nov 09, 2024 at 12:08:54PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > Replace get_raw_handled_fs_accesses() with a generic
> > landlock_merge_access_masks(), and replace get_fs_domain() with a
> > generic landlock_match_ruleset().  These helpers will also be useful fo=
r
> > other types of access.
>=20
> Of course I need to update the commit messages with the new names...

Yes, those are still using the old function names.

At this point my other two remaining remarks are so minor,
I think we can skip another version of this patch set. =F0=9F=91=8D

Thanks for simplifying the code!

=E2=80=94G=C3=BCnther


