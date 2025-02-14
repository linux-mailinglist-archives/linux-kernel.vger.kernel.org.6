Return-Path: <linux-kernel+bounces-515768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC14EA368B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74893B1D20
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA2A1FC7E8;
	Fri, 14 Feb 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ASTqSUGR"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3531FC11C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573573; cv=none; b=AjINC9oCeXcdD+cLKyNT06J0v4j3d1cXCRHJZzZIBqfePOyZYMSYlcA8rblU6SpOu4ZgZzWRW70CiXAexUjeZ4Knkc//SsdlBF1Q8PParCLHxv/9mMKlbVuS48wlc3XoMzulm4XuEQlKQGcTRsEIFE/nF/Cf6AXDhDjdNJlEgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573573; c=relaxed/simple;
	bh=HeX6ZzztVOrYisYhJTZxv4NJeWTGvza3YZmd71aq/h4=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=s9ssN2uz573iuLVb9ujfhjY/u2kXn/b/n/X++wG1NqqzCAM082fVq+F0KkG/52X/PNArhqX8HU4UHa3GiFk1/B+QbQkrQbLMy1Z7OyGlw6TpF/oxjalShbgFtCMkx9n6bFKMKPRLbp2YlKwEvyuDb7e4rUtKXQfqYdRnrPWsBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ASTqSUGR; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c072d6199eso134541185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1739573570; x=1740178370; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXHzqv9wUekHYgEpEzaIRflqoxAMgy1doGC14VRa4uE=;
        b=ASTqSUGRxqX/OFu3sR91CAlahqaJ4rCa+I7alsLmAQ3IfJPKuRbb1OgeqLGgcLn8BS
         laVRB9zYMxAJ8yytFCDgZv7ZWQWy/QSVcxL4Fgjp+xCX3bitsqobySo6WvTHCvIOZwOM
         gzjauWWZRnD6q7MCot3rgSzBVrLrGdNndF8AilXY74sVwfs6wFktr36RMsPrR9TOhcfy
         bHqdHPLc+YZGy11fVl6D/5391dmbDLgrywMBqx0iSyYNah/Mx0eYFsMCTixvzu32AoOB
         G4X9/JazYWdJk+muybtio+U4Bw33aH6fqTWzUi5vgtxrsb2eAXrBrqw8VIg120QG6c5u
         4eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739573570; x=1740178370;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WXHzqv9wUekHYgEpEzaIRflqoxAMgy1doGC14VRa4uE=;
        b=pXrtift1liu6xRDvKvCFE8neGWNZ1sQymDNAP2RdL57f5PlIUtDyNbNwSYNTxC7xs4
         QinBmtQj1OMrbVcD1IcIHf7CNTuxollUicGxB/qg3q4zxPSkcoiLjwtlO0YQRK7utpwc
         bRfWp8sbum1XkLuZd/bPwDDGeiUDRR/QaMNbqIITNcQLHgzK7pL1j5UtqXhxC2K9yjSl
         hngGj6aM+5yqT9dklJZvseSUgt2dMl8Qw8PgNiIswz+ZuH2d1jVchv3ghG2FTGXSqqS0
         4pJ9uXDTIBV8/MMWW7Fr1HFELEB2Yk043peP8j1qiNUfVskxyCTsLrTsWgjRWLXTxLAW
         htCw==
X-Forwarded-Encrypted: i=1; AJvYcCUZq2xde/jkz7hE2QePBLU3f8BXJeTMwK9j65RI9/kJ4Vi3LifU1KH/DugyB2uTeadh2ehWCkYDF//gZfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6KiA5vTNvZC8DI9MJpc/61qbDh4qRn+s+UyPLXsXKcnwUjyv
	Nyzlonb6eMD5fEAMSteA48CjyL8awFA/Z38c0yFZukXehXGq7bsXbeZtTFYHTQ==
X-Gm-Gg: ASbGncuN89dysIrPyuTYl+sCY7UeyR1F+H0N2dGUzup689CNE80wGc9A/tQNTPSySyg
	YrIrfwduhaJlFabaD1PmErujwLXJCiG9eylEFy48uz75b518DtTXNeVSTbAEqWwwNiU1/GQDnNF
	52fj88TUo30OG5TZT1xNbNZVgw709wM8FWxjkSQvzb/foPClGhSyQBpFFrNB3C+nnugUvxs3aBa
	VDl1a0XLPn/035SQea66O2Tyy/s1ia61x56Syj8d1dygCWhFSozhmCpCH8hW+1XHSmZr0R61hs+
	MIlx021Nlw==
X-Google-Smtp-Source: AGHT+IGWfis+HW8LPGn0HW7FBk16eU2pso6qWg3szjmvXnx0rBehupMkQexztXPljfWHRx5GEeDFXA==
X-Received: by 2002:a05:620a:1a1f:b0:7c0:7aab:9b66 with SMTP id af79cd13be357-7c08aa37c2cmr231469185a.40.1739573570067;
        Fri, 14 Feb 2025 14:52:50 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c07c86e5cesm253164885a.93.2025.02.14.14.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:52:49 -0800 (PST)
Date: Fri, 14 Feb 2025 17:52:49 -0500
Message-ID: <7ed44e7b0e371302d29be95789cd1a57@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250214_1255/pstg-lib:20250214_1549/pstg-pwork:20250214_1255
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 10/24] landlock: Add AUDIT_LANDLOCK_DOMAIN and log  domain status
References: <20250131163059.1139617-11-mic@digikod.net>
In-Reply-To: <20250131163059.1139617-11-mic@digikod.net>

On Jan 31, 2025 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Asynchronously log domain information when it first denies an access.
> This minimize the amount of generated logs, which makes it possible to
> always log denials since they should not happen (except with the new
> LANDLOCK_RESTRICT_SELF_QUIET flag).  These records are identified with
> the new AUDIT_LANDLOCK_DOMAIN type.
> 
> The AUDIT_LANDLOCK_DOMAIN message contains:
> - the "domain" ID which is described;
> - the "status" which can either be "allocated" or "deallocated";
> - the "mode" which is for now only "enforcing";
> - for the "allocated" status, a minimal set of properties to easily
>   identify the task that loaded the domain's policy with
>   landlock_restrict_self(2): "pid", "uid", executable path ("exe"), and
>   command line ("comm");
> - for the "deallocated" state, the number of "denials" accounted to this
>   domain, which is at least 1.
> 
> This requires each domain to save these task properties at creation
> time in the new struct landlock_details.  A reference to the PID is kept
> for the lifetime of the domain to avoid race conditions when
> investigating the related task.  The executable path is resolved and
> stored to not keep a reference to the filesystem and block related
> actions.  All these metadata are stored for the lifetime of the related
> domain and should then be minimal.  The required memory is not accounted
> to the task calling landlock_restrict_self(2) contrary to most other
> Landlock allocations (see related comment).
> 
> The AUDIT_LANDLOCK_DOMAIN record follows the first AUDIT_LANDLOCK_ACCESS
> record for the same domain, which is always followed by AUDIT_SYSCALL
> and AUDIT_PROCTITLE.  This is in line with the audit logic to first
> record the cause of an event, and then add context with other types of
> record.
> 
> Audit event sample for a first denial:
> 
>   type=LANDLOCK_ACCESS msg=audit(1732186800.349:44): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
>   type=LANDLOCK_DOMAIN msg=audit(1732186800.349:44): domain=195ba459b status=allocated mode=enforcing pid=300 uid=0 exe="/root/sandboxer" comm="sandboxer"
>   type=SYSCALL msg=audit(1732186800.349:44): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> 
> Audit event sample for a following denial:
> 
>   type=LANDLOCK_ACCESS msg=audit(1732186800.372:45): domain=195ba459b blockers=ptrace opid=1 ocomm="systemd"
>   type=SYSCALL msg=audit(1732186800.372:45): arch=c000003e syscall=101 success=no [...] pid=300 auid=0
> 
> Log domain deletion with the "deallocated" state when a domain was
> previously logged.  This makes it possible for log parsers to free
> potential resources when a domain ID will never show again.
> 
> The number of denied access requests is useful to easily check how many
> access requests a domain blocked and potentially if some of them are
> missing in logs because of audit rate limiting or audit rules.  Rate
> limiting could also drop this record though.
> 
> Audit event sample for a deletion of a domain that denied something:
> 
>   type=LANDLOCK_DOMAIN msg=audit(1732186800.393:46): domain=195ba459b status=deallocated denials=2
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250131163059.1139617-11-mic@digikod.net
> ---
> Changes since v4:
> - Rename AUDIT_LANDLOCK_DOM_{INFO,DROP} to AUDIT_LANDLOCK_DOMAIN and add
>   a "status" field, as requested by Paul.
> - Add a harcoded "mode=enforcing" to leave room for a potential future
>   permissive mode, as suggested by Paul.
> - Remove the "creation" timestamp, as suggested by Paul.
> - Move LANDLOCK_PATH_MAX_SIZE to domain.h, check the size of the
>   greatest landlock_details at build time, and improve comments.
> - Improve audit check in landlock_log_drop_domain().
> - Add missing headers.
> - Fix typo in comment.
> - Rebase on top of the landlock_log_denial() and subject type changes.
> 
> Changes since v3:
> - Log number of denied access requests with AUDIT_LANDLOCK_DOM_DROP
>   records, suggested by Tyler.
> - Do not store a struct path pointer but the resolved string instead.
>   This enables us to not block unmount of the initially restricted task
>   executable's mount point.  See the new get_current_info() and
>   get_current_exe().  A following patch add tests for this case.
> - Create and allocate a new struct landlock_details for initially
>   restricted task's information.
> - Remove audit_get_ctime() call, as requested by Paul.  We now always
>   have a standalone timestamp per Landlock domain creations.
> - Fix docstring.
> 
> Changes since v2:
> - Fix docstring.
> - Fix log_status check in log_hierarchy() to also log
>   LANDLOCK_LOG_DISABLED.
> - Add audit's creation time to domain's properties.
> - Use hexadecimal notation for domain IDs.
> - Remove domain's parent records: parent domains are not really useful
>   in the logs.  They will be available with the upcoming introspection
>   feature though.
> - Extend commit message with audit's timestamp explanation.
> 
> Changes since v1:
> - Add a ruleset's version for atomic logs.
> - Rebased on the TCP patch series.
> - Rename operation using "_" instead of "-".
> - Rename AUDIT_LANDLOCK to AUDIT_LANDLOCK_RULESET.
> - Only log when audit is enabled, but always set domain IDs.
> - Don't log task's PID/TID with log_task() because it would be redundant
>   with the SYSCALL record.
> - Remove race condition when logging ruleset creation and logging
>   ruleset modification while the related file descriptor was already
>   registered but the ruleset creation not logged yet.
> - Fix domain drop logs.
> - Move the domain drop record from the previous patch into this one.
> - Do not log domain creation but log first domain use instead.
> - Save task's properties that sandbox themselves.
> ---
>  include/uapi/linux/audit.h  |   1 +
>  security/landlock/audit.c   |  90 ++++++++++++++++++++++++++++++--
>  security/landlock/audit.h   |   7 +++
>  security/landlock/domain.c  | 101 ++++++++++++++++++++++++++++++++++++
>  security/landlock/domain.h  |  68 ++++++++++++++++++++++++
>  security/landlock/ruleset.c |   6 +++
>  6 files changed, 270 insertions(+), 3 deletions(-)

Some minor questions below, but from an audit perspective this is okay.

Acked-by: Paul Moore <paul@paul-moore.com> (Audit)

> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index b0dde6bcfb76..a5b055306757 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -8,6 +8,8 @@
>  #include <kunit/test.h>
>  #include <linux/audit.h>
>  #include <linux/lsm_audit.h>
> +#include <linux/pid.h>
> +#include <linux/uidgid.h>
>  
>  #include "audit.h"
>  #include "cred.h"
> @@ -31,6 +33,40 @@ static void log_blockers(struct audit_buffer *const ab,
>  	audit_log_format(ab, "%s", get_blocker(type));
>  }
>  
> +static void log_node(struct landlock_hierarchy *const node)
> +{
> +	struct audit_buffer *ab;
> +
> +	if (WARN_ON_ONCE(!node))
> +		return;
> +
> +	/* Ignores already logged domains.  */
> +	if (READ_ONCE(node->log_status) == LANDLOCK_LOG_RECORDED)
> +		return;
> +
> +	ab = audit_log_start(audit_context(), GFP_ATOMIC,
> +			     AUDIT_LANDLOCK_DOMAIN);

You use __GFP_NOWARN in the other calls to audit_log_start(), did you
mean to use it here as well?

> +	if (!ab)
> +		return;
> +
> +	WARN_ON_ONCE(node->id == 0);
> +	audit_log_format(
> +		ab,
> +		"domain=%llx status=allocated mode=enforcing pid=%d uid=%u exe=",
> +		node->id, pid_nr(node->details->pid),
> +		from_kuid(&init_user_ns, node->details->cred->uid));
> +	audit_log_untrustedstring(ab, node->details->exe_path);
> +	audit_log_format(ab, " comm=");
> +	audit_log_untrustedstring(ab, node->details->comm);
> +	audit_log_end(ab);
> +
> +	/*
> +	 * There may be race condition leading to logging of the same domain
> +	 * several times but that is OK.
> +	 */
> +	WRITE_ONCE(node->log_status, LANDLOCK_LOG_RECORDED);
> +}
> +
>  static struct landlock_hierarchy *
>  get_hierarchy(const struct landlock_ruleset *const domain, const size_t layer)
>  {
> @@ -106,16 +142,24 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  	if (!is_valid_request(request))
>  		return;
>  
> -	if (!unlikely(audit_context() && audit_enabled))
> -		return;
> -
>  	youngest_layer = request->layer_plus_one - 1;
>  	youngest_denied = get_hierarchy(subject->domain, youngest_layer);
>  
> +	/*
> +	 * Consistently keeps track of the number of denied access requests
> +	 * even if audit is currently disabled, if audit rules currently
> +	 * exclude this record type, or if landlock_restrict_self(2)'s flags
> +	 * quiet logs.
> +	 */
> +	atomic64_inc(&youngest_denied->num_denials);
> +
>  	/* Ignores denials after an execution. */
>  	if (!(subject->domain_exec & (1 << youngest_layer)))
>  		return;
>  
> +	if (!unlikely(audit_context() && audit_enabled))
> +		return;
> +

Not a big deal either way, but it seems like the check above should
probably be in patch 09/24.

>  	ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
>  			     AUDIT_LANDLOCK_ACCESS);
>  	if (!ab)
> @@ -125,6 +169,46 @@ void landlock_log_denial(const struct landlock_cred_security *const subject,
>  	log_blockers(ab, request->type);
>  	audit_log_lsm_data(ab, &request->audit);
>  	audit_log_end(ab);
> +
> +	/* Logs this domain if it is the first time. */
> +	log_node(youngest_denied);
> +}
> +
> +/**
> + * landlock_log_drop_domain - Create an audit record when a domain is deleted
> + *
> + * @domain: The domain being deleted.
> + *
> + * Only domains which previously appeared in the audit logs are logged again.
> + * This is useful to know when a domain will never show again in the audit log.
> + *
> + * This record is not directly tied to a syscall entry.
> + *
> + * Called by the cred_free() hook, in an uninterruptible context.
> + */
> +void landlock_log_drop_domain(const struct landlock_ruleset *const domain)
> +{
> +	struct audit_buffer *ab;
> +
> +	if (WARN_ON_ONCE(!domain->hierarchy))
> +		return;
> +
> +	if (!unlikely(audit_enabled))
> +		return;

I'm guessing you probably also want to check the audit context given
that you are doing it elsewhere?

> +	/* Ignores domains that were not logged.  */
> +	if (READ_ONCE(domain->hierarchy->log_status) != LANDLOCK_LOG_RECORDED)
> +		return;
> +
> +	ab = audit_log_start(audit_context(), GFP_ATOMIC,
> +			     AUDIT_LANDLOCK_DOMAIN);
> +	if (!ab)
> +		return;
> +
> +	audit_log_format(ab, "domain=%llx status=deallocated denials=%llu",
> +			 domain->hierarchy->id,
> +			 atomic64_read(&domain->hierarchy->num_denials));
> +	audit_log_end(ab);
>  }
>  
>  #ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST

--
paul-moore.com

