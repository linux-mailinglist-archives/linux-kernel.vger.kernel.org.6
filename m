Return-Path: <linux-kernel+bounces-399696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F999C02FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E951F237D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C841F429C;
	Thu,  7 Nov 2024 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="RaDvZKCw"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF71F4289
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976732; cv=fail; b=Qe/j3TThrmBrnmblsnBAJCsBTgArXJjqb6kRFkMKrgCoZEf4Y76mNlL+43rw/T4gQIMZDPnnuvcrzdLIs/+3MR6VUDe9w3m0FdFnQLt6GctPdXkip5pT+9ZDohCrI8i9kYPSvjDgEZ3Ec62TQirXTzLCxbK6p5waQxx2nBcPtE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976732; c=relaxed/simple;
	bh=FgFbQUJw6Y8G8aRVyKOAMdhSWlkZGo7czPZUuWhXy44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=eqVFYcTLfpAFu3GxbriyUpFLIFm/4g4OBGPATZ/b1sm0CC4Ckpoj6o2Wbcp4YNW++w7123p0z92bQyw6Gt7//jemK/gQ5YRNb9jVTh2W9xH9H0a00ryfYXsckLojI3v9CEf+e221/JuBOQfXzLb7VtzmIlrDBEPaGPGCSyOYPNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=RaDvZKCw; arc=fail smtp.client-ip=40.107.247.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ksp7XAJzYfcNmmOCFZCF8MYvrf6Qq3EmWvqKi5Yh0GrZOXxRdVKAhknymYAqx3hB3wWztbjKjwEyyNlQ61H8gICa4bls9/SJGGIznK0ox3vjNDG3tsq2sLC5Ihu/NUlWboWW9otkDOFZeoh1pZCoky4EPgdTZR3VcKjzJL2vTkUKDsNJK6TkqZ0oj1gRRV53hUvip32uvkSe6FL3KSLnTUAq8SB+zKsLjGNVQlRtfv84sY9YSdrbdIkDVnj3HUgsHkOhceWB04iD9QY1XagfFs16S9XwtZPsRaE+31VKED6YJ4AnH4II5aD4QKo9AdMcniybs0zcCQVfa/qAmIoCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omOd8/HAGitQXz7QDH55KRHCfNmBdZPk7Pd8vwo1Vqk=;
 b=haYHQDVqa4MaLxogrBSGvRRvEa/NPwSqwzz7sLlYZ0oKC/LmtZXNzJ2LcKdgqWy4PV83XYpLlqWtbwsv9YAlQYskqOjVJP5t+H/ZQnfgf0/cSumhQ7NEadr/+avUEF5Nz3nzq7ZjCZbMpp3htZ8VIUanB+M1LgIBN/bO09cJQfcd3tPmGmLf3oMmROHS8G4UkfdbqrdGjsh/FHZVnUgOk1m4oDbFOhAAzMJplKDRMkHdgOL/X80Wq+r7oEuxdXAtISH1ag0IHGIj9ZLMhYwb64ZejS5w8RBwasO9DtUZhJZ7TD6/7jIZDsJZLsvwuwMmXkTLSKTzcLePnmIXT2AB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omOd8/HAGitQXz7QDH55KRHCfNmBdZPk7Pd8vwo1Vqk=;
 b=RaDvZKCwfCGn28eoslUgnKAxf+gR98HAhCp8AfdAe3ESxtePZXiFuqJ7h3816VSlUsC4ytmdF9Fx2JQRedMOKjMg28EJtzPkKDPuYzM3QyVKvJpZBF9/3eW3QuPy2lX9yK68hDlcUnrN/fan4O228IqsmZK2sL4dTyPChoQrlMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by VI1PR10MB3135.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 10:52:02 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:52:02 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Jeff King <peff@peff.net>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,  Masahiro Yamada
 <masahiroy@kernel.org>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] setlocalversion: work around "git describe" performance
In-Reply-To: <20241106212337.GA956489@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 6 Nov 2024 16:23:37 -0500")
References: <20241106012838.435040-1-linux@rasmusvillemoes.dk>
	<20241106212337.GA956489@coredump.intra.peff.net>
Date: Thu, 07 Nov 2024 11:52:07 +0100
Message-ID: <87jzdfgvu0.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|VI1PR10MB3135:EE_
X-MS-Office365-Filtering-Correlation-Id: bad3ff6c-da83-49bb-4ecb-08dcff1a3611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CbCpyeYMbTo/5qgygN7g5/p5v/Bcb29rIp3kdYvbuyLX8dAPw8aarmaQnCXl?=
 =?us-ascii?Q?x5exZh62A6wsxTdgtBJZKPWGnyqy0SnZ+f1m2JdGLSiOslDvJBEYmVQwOV6z?=
 =?us-ascii?Q?kcDVFNJdTr21Z5WSNkDCWlm6HNgUE8kOW9r8FXloD6z4/Yo6uY5baEhGrLkM?=
 =?us-ascii?Q?nPCgyFvqLwcA0r5n4ylz2ZiyoKqWJdfw8GWxcd2ur4axJ0mDrNNXPQ5kS2+0?=
 =?us-ascii?Q?lw1Vnxy1hWfa/6jkl5Vc4zf+EO8MjWEm5gevod4cIGm3mcUPNGPnDPugkXEw?=
 =?us-ascii?Q?N8rlLvMeCVB0R/a3z5KxTGNsEe/q6N/2++vQlVvst5Z9+lplev+h0lEAmvzp?=
 =?us-ascii?Q?7CucI8onOBtFVqfXOqqNmtLlxthUC0bqUXZgKDtHQ2okdMDTjMIkCDdTRQrY?=
 =?us-ascii?Q?XprXMnoUS84tHDeysJaK+Zf3i73n7WEYFpz+nEWZncYniId1AkVl+9J4CHK8?=
 =?us-ascii?Q?Nq36M7KfhgkZOpEdDLLLuDMreDvCqHL+AOY3nuE6+yyhNfhSrCLq1jyEHfAS?=
 =?us-ascii?Q?+c50S8M8A5Khr98C+oGpwSAFg98mIbTyoO+IS8A1LZ8T4mXcHxUmj9lI2Sn2?=
 =?us-ascii?Q?TrunDzMAvt07MYawQ6JGPFIGjzGiJcaAx5XLnUgS/BWPlF5wzdbOI798Dk59?=
 =?us-ascii?Q?JIv2HQSAbA6BOrKEXbgVb0wgqKV9B01IxkQtuUb0dovTBrc116d4jJFyKez+?=
 =?us-ascii?Q?3qF/sf087U37GhIn6+GIx2Di2dyS3eWgX+NGn9Og/4ujkAdmAAOLalGsnsWv?=
 =?us-ascii?Q?HNuMYhPJcB0NNSKm0Y9UQgzPTMe8Ah2XscqbeEJFdyfhK+2yxkTwd95gqaqC?=
 =?us-ascii?Q?B6TWkvSyjIihZJXMzGzKgGiCmnxz3NPdSct3grQ8E9G0dK5KEb4mXntWR+T7?=
 =?us-ascii?Q?fMyjhWUx0XAWVytBh8kh1KDV3+RGBJhK/cFd3JBZrhebrJjJn1gpLEdiypVO?=
 =?us-ascii?Q?JRLnAjKCl9KJjq6NRR1R7Zz5JBnF1/yHhtHL/MAG6eEw/4eHkirlEX1uhlJO?=
 =?us-ascii?Q?AE+Zf064TNCQfbHOslLuoki9kIah+1DMFBTFa3hQdl8us3COCCul92P+GcJu?=
 =?us-ascii?Q?xskR+i3AcRJEhP89Hi0BDpOFpDimKXjTQUHJ+gxWfXXNXtewunC63djGQWEs?=
 =?us-ascii?Q?NF2h/ahMXi+8SiglBcsEQbg/Ts4rQZ80FddMW8tbvyHl+cNUG2//qugNr3Jj?=
 =?us-ascii?Q?4D5rqwtKULHKUaoc/k4npoUubix5F5+SRG1HSxskeIO1Rgcs8CT9oKGoL3Bg?=
 =?us-ascii?Q?tm0gmV7yB8CW9co1H7sPfH7JEqcaKXiLBFogVkdBcla4Y6+kVXsHt+KR2rUi?=
 =?us-ascii?Q?+sw1+ke1NSgkGCZYwr8JwYXCJzHB/yRu2wWo8HL14zyN1SQRkElYaYVmBx7/?=
 =?us-ascii?Q?mzKlYFQPtaRp6QF4qNd7GUelVYmV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w5rQ95E2CWqzWuTTrH0lu7Fmo0CwFUQXR6w8/0UV7yf+aURyCr+96gesIlpQ?=
 =?us-ascii?Q?vYlfJtDQ0BzOQFgDrNfNAOQwALj8Y8vkjgE5QR1GHeUwa1a3qZE9IiabPI29?=
 =?us-ascii?Q?ZCj8bxZQyDZQhK3zwQ1KoCjsxvgy1bnIggSTYTHVnRrRFMU2ZBpIChao96c6?=
 =?us-ascii?Q?sb5+Lq4CzsCmysX4dj3NGUg0RRVjvdlHmX5y0ErHPDYCdV3TZPUHgYno4+ZU?=
 =?us-ascii?Q?LSK4sbe+ru0Iwj4RcK9bMWfHqQPzM93kNWYiA7HUqaFKNZXDfhlulkUFBEm+?=
 =?us-ascii?Q?iRtZBrdaV0pLTE0djoIBX+fsKRG0/eL8YP7btK/0SEInlKebacNm4HVvDbzw?=
 =?us-ascii?Q?uSQVNTrxFbp3nnwswJCqPhUmwTouAvnDk0BWceCdnUI2cIeZ+jmNe0SiGlaK?=
 =?us-ascii?Q?WbuGAzyV8Ha8WpKrFHHWKpJxUzvegCHUaJkhnclOXpNshTfFA2tQ30hXDDps?=
 =?us-ascii?Q?WLR6mk20+MxfiNu+XBvCkw1sMpWzcgp1tBWRVlNXHUIwsItCHYXXHU/4qGdb?=
 =?us-ascii?Q?Y9vRnDV81/GQTSg6zJlqJVUAREWILENqmoMf6927F3lalNF0QkY8ZVuC7i+X?=
 =?us-ascii?Q?iQq9pyCNyV/04y1kq1kUM1YiCJS54aw0GhcsCC49+nNMI5nLkhzFRn8NmOal?=
 =?us-ascii?Q?CG4tQB4mAIaltSSbAqRuc5LqTpkYpFKTDzmEew44MtuNk03vlJwydz98t8GL?=
 =?us-ascii?Q?l7X7c8HmAtSuAKh4ifLvY8CvKwkIKdVjak+o0N1G0+7z7ivSuKxp05dmf5fI?=
 =?us-ascii?Q?N6/zpjT5vGwbXTGCw0GUNvMAyTcFmyrcw7soJ0qIfjD1+/08458K2FeIhApB?=
 =?us-ascii?Q?Z50MctXHDaYze7EqRlUePLhDw47Q0116Z5c5AZ40I3uTOtC27BYbeUjuibNd?=
 =?us-ascii?Q?99LEqbMPrRxwMxw2tWg6BlV/BX4UqwGu5Q3y57jwzRb8+GdH6VQJxW8sDlM0?=
 =?us-ascii?Q?jndEMOmE3vrd10XwcvKY/2UIm4bZBxGybrwvgI0tkdftpzMP0iqO4WdfuhGQ?=
 =?us-ascii?Q?NBnEgRsRZPDi/qZmGCJ5SliUhYqK7dsRP/CJ19GQan96+ZswOiepCFO8Eilb?=
 =?us-ascii?Q?HsLX6d9FG9/lTssRD8dg2gMxoGnl2cPHcIt/ZGP5m2/5CngaEt4wVkJSUs/g?=
 =?us-ascii?Q?lvvpDUjDwxj8BwF3rEbuhds3pQ74NqnmpfZdPu3jx6xuvtZGImPXA3udEh1T?=
 =?us-ascii?Q?WOFPW6lzcBHYlZ7O2dk6D+zY8C7j/CIO/pHiB5GbY+vpAUMnUnG4jXfpvecn?=
 =?us-ascii?Q?cAjD2LkRzmAVLGxYTBPO08pUNd32PrCEjFMxJ6OmSFpEB09N9s8S/N5sDQdb?=
 =?us-ascii?Q?Tw5xmbNQkwr94sKt8JramrJeDf0HTqEiN1u0RT6iCVCA5WZGJC6TpERZtYLt?=
 =?us-ascii?Q?mGxAwrgeFqIqhiDQHp+rtYeRdzU5mw9wIqjoGqs4sJfYC+FKJMVvMMskLQWP?=
 =?us-ascii?Q?VOpL8waaECcsFBZfttLeUeMhNADi2P1kdmYjJtxurqGRyT7rZhRLvoPaFnHU?=
 =?us-ascii?Q?NoSAAycmOcTfa93nmGyJLHpCRF7V4Hij4049mJqFcbzXPzxRQRdwmt2gNDO4?=
 =?us-ascii?Q?1o+h9eVuhJyt4zj27gS6IgUcNHmt0/979Le1jeYBkV/S7NBx9dYmBZfscdv4?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bad3ff6c-da83-49bb-4ecb-08dcff1a3611
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:52:02.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEYLFlH5HOWVAn8ngEpZMBKCJe4Ouqt8uJlbxox/nj11T+ynkO/BA4zDMkbF7Ogo8fWTqcuNCRN06wdzL5JsHovOwlyyicljoI1h77G0LT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3135

On Wed, Nov 06 2024, Jeff King <peff@peff.net> wrote:

> On Wed, Nov 06, 2024 at 02:28:38AM +0100, Rasmus Villemoes wrote:
>
>> This has been acknowledged as a performance bug in git [1]. However,
>> no solution is yet in git.git, and even when one lands, it will take
>> quite a while before it finds its way to a release and for
>> $random_kernel_developer to pick that up.
>
> I just posted patches in:
>
>   https://lore.kernel.org/git/20241106192236.GC880133@coredump.intra.peff.net/
>
> but I agree it is worth dealing with in the interim. And also, I really
> suspect that this new code may end up faster than git-describe in some
> cases anyway.
>
>> +try_tag() {
>> +	tag="$1"
>> +
>> +	# Is $tag an annotated tag?
>> +	[ "$(git cat-file -t "$tag" 2> /dev/null)" = "tag" ] || return 1
>> +
>> +	# Is it an ancestor of HEAD, and if so, how many commits are in $tag..HEAD?
>> +	read left right <<EOF || return 1
>> +$(git rev-list --count --left-right "$tag"...HEAD 2> /dev/null)
>> +EOF
>> +
>> +	# $left is 0 if and only if $tag is an ancestor of HEAD
>> +	[ "$left" -eq 0 ] || return 1
>> +
>> +	# $right is the number of commits in the range $tag..HEAD, possibly 0.
>> +	count="$right"
>> +
>> +	return 0
>> +}
>
> The git parts all look good to me here (and not knowing much about the
> kernel's scripts I'll refrain from even looking closely at the other
> parts).
>
> The use of the here-doc is a little funny, but I guess you can't just
> pipe to read since that would put it in a subshell.

Exactly. I try to avoid string manipulation using "$(echo ... | cut
...)" etc. when I can get away with doing it in the shell itself, which
sometimes leads to some awkward constructions.

> But I do note that your "|| return 1" won't catch a failure from
> "rev-list", if that was the intent.

Well, not a failure from rev-list itself, but I thought that when the
command ended up producing nothing on stdout for read to consume, read
would fail. But you are right, that doesn't work as I expected.

  $ printf '' | read left right ; echo "$?"
  1
  $ printf '\n' | read left right ; echo "$?"
  0

I'd need for the inner $() to not strip a newline, and for the heredoc
to not implicitly add one, for read to actually fail.

>I think you'd have to use a real tempfile to catch it, or
> play horrid tricks with echoing $? into the "read" stream. I guess the
> explicit check for "$left -eq 0" will catch most failures anyway.

Yes, except that I should probably then use string comparison = instead
of -eq, since $left will be empty when rev-list hasn't produced any
output.

Maybe

  set -- $(git rev-list ... 2> /dev/null)
  left="$1"
  right="$2"

is simpler. There's also

  left_right="$(git rev-list ...)"
  left="${left_right%	*}"
  right="${left_right#*	}"

where the whitespace are actually tab characters, but that's probably
too subtle.

> If you use "<<-" you can get rid of the awkward indentation.

Ack, thanks for the reminder. I seemed to remember that as a bash
extension, but it's not.

Rasmus

