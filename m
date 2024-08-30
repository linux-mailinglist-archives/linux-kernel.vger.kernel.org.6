Return-Path: <linux-kernel+bounces-307853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 596DE9653FC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B6B1F239CD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AF93C0B;
	Fri, 30 Aug 2024 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W9rPqE/Z"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB920EB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977633; cv=none; b=jx5KitWHowOrqPPQn34wWvh9grsq6DjkkOzK6o/Lqos7GonsNrH0IBj4DJZup4Nzlk4uPUC9WujPcVgZSn8BYrcBD6lei3FLShdMRgACZnD177/UNBp0uU9iUXql6fP1ojFiBq9wcSm2ACEAWUhoO6Ax3LnNNcsO9mHr10CCpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977633; c=relaxed/simple;
	bh=bJd9I32v7Otg4KdUboUZFduUF4MCAqDOB8cOCWhBtsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WO0h/DGr3QMxq+8n14xqlCL/hO3dlfTlBfUJ6sJWkLSsAVEX1n5l67iRQ6cKdnI0jZHM1N3C1AB6xbxZpJ6t+Q/jtg8+NnU71lNy3kx3yOs3b9lS8UbFXfoStyfIjS80MFncnagQewKFvndMCCTG1DMz2EwaN1oMs3raa7Ghbgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W9rPqE/Z; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86c476f679so158177266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724977628; x=1725582428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0U2GctD6QRgRftcHbwdJFZ3yjPiOgv4RiUO/asYgyGY=;
        b=W9rPqE/Zr5zlfmXkb42q8EjBvSCNp0os45rzNaiq5I97nExyat1eXbe3tOFMT1n/WR
         AG4xveJ8nSrIRbfyGeLqdE9fJjwHg8oDQma1kHU5z7lU7EXct8qaehGS3rKlj3YGFU0b
         44SrLEmm1tz7M8/eUOSpez279rxyTEqMEJWCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724977628; x=1725582428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0U2GctD6QRgRftcHbwdJFZ3yjPiOgv4RiUO/asYgyGY=;
        b=EOC234JorUO2GFlXBc1Cp9HGG2ckk+3wlF+JGtgYXCMZQjiUlupgxdaFWVVYJNSZbM
         9xDab4RBJLMdyxhSZv0gUfzEls/XmvLK4uofcPlWulaA5ibxFZ9lWqvO1ahAz/vl/buS
         l4cNfiwApjeo3VYzy/t1SU/AnmjC8Y+gN+Hq4RD+M0GErTZSdmVqfkhL8DOt/b8tLmi3
         im/BriWeDwyVm+FI0lwX01pFjlBm0Cox5CgtT0TlI0SJDkyAdEE11vDRsB7FF6snoQxL
         YSDYZGf8A1G4bhje+obNIGzp1vL63flJmUIm82mEtDcBgv1n9d7sHU5S/wC+IBnptdGW
         F6yw==
X-Forwarded-Encrypted: i=1; AJvYcCWAOoE3hTsGwzi1DFT7vV1dL3O/do2V9MClivcAZjIPXfoJypcKjW3Z91UHa26XJHEoRIJlhLsY4HOuD4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywep+epr9/mmky0QLOmJYONq1QfC6wMDlLTtgRblqB+fBGI1HlV
	MCswAyjZ5yues9uJE6kOPmsT4G71DPXS4lzfv86f3veOShreDRzTuBnhVZA7i+SJipQ+V1ipDBZ
	DnMC/DQ==
X-Google-Smtp-Source: AGHT+IH+RJtwGcly7h3QiqtLjxzjx1LD/6tX8FLIQWX8we+6u2WqIQtfxca2d2QbGgjfN8Kza+1E2A==
X-Received: by 2002:a17:906:dac6:b0:a86:6858:8a8f with SMTP id a640c23a62f3a-a897f84bce7mr357861566b.26.1724977627461;
        Thu, 29 Aug 2024 17:27:07 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fea68dsm140500966b.26.2024.08.29.17.27.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 17:27:06 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3718acbc87fso710388f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:27:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUd+RX1t8M6xqMxO11nyJzX7W3OUbmZYP6aav+AJrbuhQhhqO4LGe1qyzehOwa1akFEYSIz9tAw2GEwf3I=@vger.kernel.org
X-Received: by 2002:adf:b647:0:b0:368:526d:41d8 with SMTP id
 ffacd0b85a97d-3749b548673mr2714437f8f.23.1724977626257; Thu, 29 Aug 2024
 17:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829182049.287086-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20240829182049.287086-1-stephen.s.brennan@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Aug 2024 12:26:49 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjKbgRY+Jvu2GNaDXaAhyydOOW-R=0qCzM3mTLrZZg+iQ@mail.gmail.com>
Message-ID: <CAHk-=wjKbgRY+Jvu2GNaDXaAhyydOOW-R=0qCzM3mTLrZZg+iQ@mail.gmail.com>
Subject: Re: [PATCH] dcache: don't discard dentry_hashtable or d_hash_shift
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 06:21, Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> I know this "fix" may seem a bit silly, but reading out the dentry
> hashtable contents from a core dump or live system has been a real life
> saver when debugging dentry cache bloat issues. Could we do something
> like this (even making it opt-in would be great) for v6.11?

Sure, applied with fixes to the comment (you seem to have dropped a word).

             Linus

