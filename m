Return-Path: <linux-kernel+bounces-576256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A9A70CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03947A5EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32C26A08F;
	Tue, 25 Mar 2025 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bz9dH6x9"
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1FE13633F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941576; cv=none; b=rENxAzvtuov9EWSGamKlenjreBUp2l03cURomGw7ONGd5wmRueDLHfgSfSR+D6D7gOxraJfWDJm3pPBgGW4hyuZDj05OKT2gHEnhjuR6m1tMkgSF4mqb9DDx9yMoji9UzsxCkoF36mClpUSWFtsmvoD8nc7b2364KOTwh5LmUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941576; c=relaxed/simple;
	bh=KKtFXFITA4hOuLwA4HcWHFD1w/QWq7sNwvdwYb0AV3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f15JSZlY/sn9GKVU84Y4r7L5CZESeiXAyjELQaSrrr6NSCmOOphjkherYs6ysrpcjhIF0lrDG+bGm/FvMmBgB9cTB/qTi1y19KRkmVb2ckJO4VPK9aglZWL1req98weQCF6E26ZuhtRjcd2fRg5lB03g+wZLfuHlYRxlypmsUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bz9dH6x9; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2255003f4c6so119719245ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941574; x=1743546374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKtFXFITA4hOuLwA4HcWHFD1w/QWq7sNwvdwYb0AV3c=;
        b=bz9dH6x9Mz+fIEKoQQzJKPqpr4dPafCNM4vlLhiEYAoZ/V8uyM1JQO9SBkKlOkFLtZ
         8Wbyqgo/mgcm9xGnBVBBpAeMPoYlKQR7IKLHQthPHb4vxX6UdDrygIqCVq1Vabv/Fyp4
         CujRq0VEDYcKdcl8it5KKfx5oRfYEQmEbQIP44kzSNzYVBlgg0k9wCpH16TVfAu+IU4/
         SKmsoE9OGhGxcgMNvkZRtP2MPlkHwoeZgJFdfwxjJrwR9VcehdG7BnmuLHwGoW0vJFsq
         8SbVu1lQlgz5eH7LpixyYMW3MBfjvFUmC62YLrr7LA113yQGkrPX9U8N1Uf7/grc9Fsm
         dJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941574; x=1743546374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKtFXFITA4hOuLwA4HcWHFD1w/QWq7sNwvdwYb0AV3c=;
        b=tDoQFrOGxmNHNVEgTjOE8vqksVJEd2ScjNtbaApCZZEtANRpkMy8nUbHlbDbZcY0yR
         9dhCTKOxFriP6TgCQs3b11qoNP7kU9Jg/ScMlPNwOOX/IDxHvjVSWuQ41uGjQGNJIq3L
         3FLoLG+pd1fKYF4EVv9RnFx5wUO5AsWauoHUPzsZgMgG5A2goIxifqvikXrLgy+nMCwH
         V+8LPLOsCF/2lZJvFGpQ/6NnBJedn3Tnme7gxugWOuVkzMV9tcyReD6bJs6A9uz7ELbt
         g1W0lUXHodqs49DZRJOknPOWlLdfzAbtwqHUZoh9IGocy51tfg1kXo5PdVxcRKrhKaCZ
         gr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJtr9lFa88C/T+uxE8YdTDJW++tD9MHjYmvntntaKpDsA+9whJBd8XXCwio72H5RhoQsIn6iGFOgeHGgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7o0w3JLP4aRojQ7CZ03qj4fUHOZof2UKf0bFD7A4FajCVOhGY
	PYV7V3XgfrGoK3ew/uNYI/0zWkqwCqsnW8SVBgWTFHyCcRB+QzT7KvU/VMJjzqguHO9r53+MtEr
	8TybsPzXt1HJNYPefU3EGFBAG0zB4iBGZrHbCqEcMDgNgFFXV
X-Gm-Gg: ASbGncvGf9QvwU1Dd8N31qX+7+i+6mY+/WRjL8GSCNi+ZQwgWDkDBFIfF1bS/CJT5c/
	CVDOIwztefNyLXHs1jV5lAmTUWJKFyGIJdPbsY5jQGTTh9PnWQOtlKQywTsan+vMIp1FGaQdbIW
	/h4CXNwO7/Kyzxv8j5k0D88R1mHxOHBijy1HY+FHmpwtwwiUE7mX3JUOdiTHMgFacGw7dFO5G1U
	YqPDRsj3KGfBtXU38cAaxy/wHrpw0FQ2p6ThdZRXwelN/6rpM2onAuzyPm+GDMGL+xmuBALgIPc
	2I1Z0HTvJSP+jzZRdUXKY7edO+oXcIHytWE=
X-Google-Smtp-Source: AGHT+IGT0KKJcSpjdtMSKMKsUWymjpS7sayjzqsLE4bPkiJaL54O/zO+3IKG+hoGFZrocDh08pKlkUao+W+O
X-Received: by 2002:a17:902:f683:b0:21f:136a:a374 with SMTP id d9443c01a7336-22780e25b3dmr295953605ad.43.1742941574203;
        Tue, 25 Mar 2025 15:26:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-227eb1938c4sm643615ad.58.2025.03.25.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:26:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 70C3234041F;
	Tue, 25 Mar 2025 16:26:13 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0EFD8E40158; Tue, 25 Mar 2025 16:26:13 -0600 (MDT)
Date: Tue, 25 Mar 2025 16:26:13 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: ublk: kublk: use ioctl-encoded opcodes
Message-ID: <Z+MthdcV2jaSBnwC@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-ublk_timeout-v1-1-262f0121a7bd@purestorage.com>

On Tue, Mar 25, 2025 at 04:19:31PM -0600, Uday Shankar wrote:
> There are a couple of places in the kublk selftests ublk server which
> use the legacy ublk opcodes. These operations fail (with -EOPNOTSUPP) on
> a kernel compiled without CONFIG_BLKDEV_UBLK_LEGACY_OPCODES set. We
> could easily require it to be set as a prerequisite for these selftests,
> but since new applications should not be using the legacy opcodes, use
> the ioctl-encoded opcodes everywhere in kublk.

Is it required to allow for the building of old userspace code (using
legacy opcodes) against new kernel headers? Or do we only need to
guarantee that old userspace code using legacy opcodes that is already
compiled continues to work against newer ublk_drv? If it's the latter
case, maybe we can consider removing the legacy opcode definitions from
the userspace header as a follow-on change?


