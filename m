Return-Path: <linux-kernel+bounces-391411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC1D9B8657
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729A61F22766
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FC01EABA6;
	Thu, 31 Oct 2024 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QA7Izg30"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BA1DFD81
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415230; cv=none; b=ZDpqsgTXMzPehJ+h2dNnRZIyWbxsntX/g+I6YW94U1VChYCfwxKd8aLdmQm/iUBelPMNW5HD3yc5UPB52xTZPQaY/fg34JkMd5M7fB9B4fRfS3PVEwmbjWwZWyEJ6GwjB9aRRQjJsTkDUCkkocX8NsBvetBtaBYnSZHcoQDrhOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415230; c=relaxed/simple;
	bh=lZVUy6CT2xfH+CAuoNtGeBUN2aklgjohf5KFRghgbZI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=YNxcAmH1J5cl9j31lHIxU6h2ypYwC+ecDhfSXBjmUZaYn8Sz5LArXNDmM7D5GGxIQUWUZ2MDBX+jKeac9r81F18oibdmjkghjBcZhLfyKL8YMs7K+1GQsBcjrCpP23DYfrMJewLeg7YqmEEpyBft5e/g8fTWxP9rC/NQI7KMg08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QA7Izg30; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b155cca097so123569085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730415223; x=1731020023; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OryhN0ZlONGvRFH33cTUoM2Hme/OP4dCS9YbGTHGdck=;
        b=QA7Izg30oc1vSG7IsFKrq9RLxYzvsbftt3+mwW8M/gLWL6yymnkgjat/jgaP5Gnvzf
         04qUb508rVrhEZ5odZJruRTOlAW1ZltWqPQcce733v2cWQhmnB5wmGUvrC70VOIdzG/v
         vWz3RdIwcaFbOr9i0MU11S5+S9uokYe4aL6xyg5oiMjpy1rnjBUM/oUxZEr+cekeJTdA
         Cx5ipMpOpZ3wCVh927SZ4y9hkQTEfEsinUchc4/Xfvv1k3YgXSbgE2IEj/7N0Las8LmN
         3rz/5b6FHzv7zsGXZmy38fwSGwRt0P6Tpnx0nm2fJTBdZT4xwiJnvqdHWXeaUyZoqeMP
         9bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415223; x=1731020023;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OryhN0ZlONGvRFH33cTUoM2Hme/OP4dCS9YbGTHGdck=;
        b=Q3OyJK0tSzi4zsplHwTV24JOm92U5rj+H23fZEvPzLP8bA6OLqLfG0xjJbWtoBzsbe
         0wUyY1sHb5Hxzakybi29l1K6C/TYpYiv/SUTLalY0ovcuXsTpBGW+rOaxeGM2WamALlr
         JbYv4KdiAvA7DdR0K9F1qieRse7WN1NCdImQIVZXVyj0UxGkYGgLzqq1I3/1zvWZEd5M
         CuJ6F/AKBFNR0blEDtrua3TQ6kSsK0gIFG2dRqEvgVrBukiRvMxg1w8SkT0pv7b1Zqqh
         P6n80ccdjhW6Kjl+g2iKseasSB7LR+591M2w79rUsJK2BXrwZXgVemlIiAexruTX6blx
         wdfg==
X-Forwarded-Encrypted: i=1; AJvYcCX+XdfDBrQszyoIkMLAXu1DHrhrZMRlBFMnfMs1ym0KmO3dMlf8lWyiyml4zu+3tNQRcmGJl3uuS+1LEog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrAXkNLcNGLXBMbEc2NZiCnPRMsnstAhnxVcOYUBfs/B9gEv25
	l7v2MT5gJ2Ir957qhx9UCovQ4FODjZWCpoK6ul87hrapktFy3g9HpzCcaEtXPQ==
X-Google-Smtp-Source: AGHT+IGk3MtE2UlABsbiTHjlYLvi4TvMpopHs6UsBnSfvXRUKlH33/ovhbphFSBsW/Hi7+aTcXuQLg==
X-Received: by 2002:a05:620a:40d3:b0:7b1:8cfa:9222 with SMTP id af79cd13be357-7b2f3cd6603mr653801485a.1.1730415222731;
        Thu, 31 Oct 2024 15:53:42 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a9babfsm114210485a.125.2024.10.31.15.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:53:42 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:53:41 -0400
Message-ID: <424b4bb4db5c4e126072179ac8ac8fd2@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241031_1534/pstg-lib:20241031_1459/pstg-pwork:20241031_1534
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v3 5/5] LSM: secctx provider check on release
References: <20241023212158.18718-6-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-6-casey@schaufler-ca.com>

On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Verify that the LSM releasing the secctx is the LSM that
> allocated it. This was not necessary when only one LSM could
> create a secctx, but once there can be more than one it is.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/apparmor/secid.c | 13 +++++--------
>  security/selinux/hooks.c  | 13 +++++--------
>  2 files changed, 10 insertions(+), 16 deletions(-)

See my note on patch 1/5, merging into lsm/dev.

--
paul-moore.com

