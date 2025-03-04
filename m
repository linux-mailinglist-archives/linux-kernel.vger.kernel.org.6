Return-Path: <linux-kernel+bounces-544006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B48A1A4DC4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2764316EC76
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B341FECAE;
	Tue,  4 Mar 2025 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POVDISCp"
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071141F9F73
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086918; cv=none; b=c/RNTcOZBAfbY4T1Jw6OuxKtBE2MxpS3Y9DroTR30Kdxva2CEM7bP4sODDhHcL0cp7SjxkpyDXKqP4a1qdhTqziS5cEh023Q0Bx4m+WMCg6+auVfVlpzS3jqZsisl9K1BdQ5aNBYkDlhfFgIPNpye/udSSxl5WLp5XpVWF5IuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086918; c=relaxed/simple;
	bh=00J+U2HrXRRY9mo+XD37HuUOAnY6kI5heqWQuH+9eY0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qZSeePqQnHb6LiwDTAd6MMbql6GgJXvd4gSpP/FJGwWJD80ogOa5bIr/RjEBBQfAQHsOQt2xKAo27UZPLbJ/bebzvb2TuEywEUGaSA6dPKKP526mN7aGY33ywDLPw1wFDVWhFF803LRPl5RaJyuDjNPYjoqsGCk0lLVtlTH5kpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POVDISCp; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6fd2fca1cebso34303747b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741086915; x=1741691715; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u1u6A3exscEAR1j00w/e4EA5kReEo6jf+SB/fNoSzP8=;
        b=POVDISCp0r/UDlFBktO53/qLsK9sca3KA5H3vwzmGjLCBy3o/dNNtsW9epKwVyd4kF
         eZ4GVYTCAN2fwidvcw0ZKgf+hPPCrc38obZHuyeeEfZxBe2vpgerSfjZuFqvOxGg4Izh
         oYfJMTIWn11IfoKqDFIWV2PAzxlKSElLIwmFK2QZI5VG93X1t64hnoqAPLhDVc0ZCZFL
         VvLRoKSv4hf0SMClWTA+ZjgJAgsOHo56/kh3nRsOCvsrxlCba/gyPMGtixp/D2DxKNA0
         o0v5a+sOdgim5qfTdUYckkX40HO6qm+Q5ta++vOcpgdUER9kHUuihOVhlK3W4NMV+Uly
         DZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086915; x=1741691715;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1u6A3exscEAR1j00w/e4EA5kReEo6jf+SB/fNoSzP8=;
        b=bAl4dqFPrjCe6AZkRvX1lS8pDqY3xQIxLX7W3oElMusynSR5g4YHSlxa171woxo7Qf
         hFS94Gbm8gUSplqg6BFflniH0clUfPl6mSF3GG8qfAM16b37LPgp7R0goGTmxxqBMN88
         Zucr7y7dB5yilcCtd0aeyqoYLKJAv1/g58RVCQyBr/9iMssKVW9dca0MQw5iqJHw2O3f
         aKN28mGKvqlMWhFjWPuob3pfY5KGsxZ2TahaKI22FyNZ8wAy2vLRoMO62PK6jV0DgWIM
         XEfgStHhF/L1fJC31p/MXqaxHcsR9EIzalVwx/9VXW0WYNHl0S5FXEJ19ACD63y3/1c7
         +4LA==
X-Gm-Message-State: AOJu0Yyn89WCMBM9QmLNtz9Wj5WFFm1GolScAeiICeAgYJsXAovW7L/B
	R6EUPVmlIXI7Qyo6Nok5ZMotewleVsxDGnSSqfUR9VshzxuPYz5L5yb2ZgQddyEnKMBf2LDEreq
	sOm++Ro2/ikr8Qxa9RIUdSfEp3pEfEdU0nsOoqA==
X-Gm-Gg: ASbGncsEH5SFM7NKnbSdpiH4Y5fxDyclkwpor/9sU3c8VWe3iAtp0knDZD6yn8z8+a5
	l0A56NcjYghpCJAAuRVBXa2NDbzM3Q9FgQDRiDWLJ9W9ZxC92cDT5C9RQxMxbw6J5BniSjeSgXf
	+9EV8qvMv3sMcz7VFK43fhgL7uGw4Ot50POR16U88xoH/WNj++YYJxkbIxM9eA
X-Google-Smtp-Source: AGHT+IFdtYnSUcgnZsvzol9jjNu0Rj+3gPWbD3nvh9IMBA/D7qJM3ijFShXtfefT6CkR4RvPfOcxZASRs6TEyobkefI=
X-Received: by 2002:a05:690c:4a0e:b0:6fb:1c5a:80fc with SMTP id
 00721157ae682-6fd4a0c405amr221510397b3.26.1741086914711; Tue, 04 Mar 2025
 03:15:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Tue, 4 Mar 2025 16:45:03 +0530
X-Gm-Features: AQ5f1JrIOLst8nuuw5P0b3AcgW5j5lUkG1UzngpbN8TTcp3rgPG0hxYIsBycA7c
Message-ID: <CAFf+5ziHz+v=iOaS+3bQ+LMoOuvmruR3o_7+sXH5Au_6tf08KA@mail.gmail.com>
Subject: Example program (user_menu_code.c) for presenting a text menu to the
 user and getting a valid option from the user.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

--------------------------
user_menu_code.c
--------------------------


/*
 * License: This file has been released under GNU General Public License,
 *          version 2 (GPLv2).
 *
 * The license details can be found here:
 *                  https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#define NUM_TRUE  1
#define NUM_FALSE 0

// function prototypes for gcc flag -Werror-implicit-function-declaration
char *get_input_from_stdin_and_discard_extra_characters(char *str, long size);
int is_str_a_number(const char *str);
void print_menu(void);
int print_menu_and_get_valid_user_option(void);
void process_user_option(int option);
void __func(int option);

char *get_input_from_stdin_and_discard_extra_characters(char *str, long size)
{

    int c = 0;
    long i = 0;

    // If 'size' is 0 then this function will discard all input and return NULL.
    // No need to check 'str' if 'size' is 0.
    if (size == 0) {
        // discard all input
        while ((c = getchar()) && (c != '\n') && (c != EOF));
        return NULL;
    }

    if (str == NULL)
        return NULL;

    if (size < 0)
        return NULL;

    for (i = 0; i < (size - 1); i = i + 1) {

        c = getchar();

        if ((c == '\n') || (c == EOF)) {
            str[i] = 0;
            return str;
        }

        str[i] = (char)(c);

    } // end of for loop

    str[i] = 0;

    // discard rest of input
    while ((c = getchar()) && (c != '\n') && (c != EOF));

    return str;

} // end of function get_input_from_stdin_and_discard_extra_characters()

int is_str_a_number(const char *str)
{

    char c = '=';

    if (str == NULL) {
        return NUM_FALSE;
    }

    if (str[0] == '\0') { // empty string
        return NUM_FALSE;
    }

    while ((c = *str)) {
        if ((c < '0') || (c > '9')) {
            return NUM_FALSE;
        }
        str++;
    }

    return NUM_TRUE;

} // end of function is_str_a_number()

void print_menu(void)
{

    printf("\n\n");

    printf("----\n");
    printf("Menu\n");
    printf("----\n");
    printf("\n");

    printf("1. Option 1\n");
    printf("2. Option 2\n");
    printf("3. Option 3\n");
    printf("4. Exit\n");

    return;

} // end of function print_menu()

int print_menu_and_get_valid_user_option(void)
{
#define MIN_USER_OPTION 1
#define MAX_USER_OPTION 4
#define OPTION_SIZE     8

    char option_str[OPTION_SIZE] = {0};
    int option = -1;

    while (1) {

        print_menu();

        printf("\n");

        while (1) {

            printf("Please enter a valid option (%d - %d)"
                   " (spaces not allowed): ", MIN_USER_OPTION, MAX_USER_OPTION);

            get_input_from_stdin_and_discard_extra_characters(option_str,
                                                              OPTION_SIZE);

            if (is_str_a_number(option_str) != NUM_TRUE) {
                continue;
            }

            option = atoi(option_str);

            if ((option < MIN_USER_OPTION) || (option > MAX_USER_OPTION)) {
                continue;
            }

            printf("\n");
            printf("Option number given by the user is: %d\n", option);
            printf("\n");
            printf("Do you want to proceed (Enter only 'n' (without the quotes)"
                   " for not proceeding, enter any thing else for proceeding):"
                   " ");
            get_input_from_stdin_and_discard_extra_characters(option_str,
                                                              OPTION_SIZE);
            if (strcmp(option_str, "n") != 0) {
                return option;
            }

            break;

        } // end of inner while(1) loop

    }  // end of outer while(1) loop

    // Unreachable code. Program execution should not reach here.
    // Exit the program.
    printf("\n");
    printf("Line %d: Some BUG in the program. Exiting..\n", __LINE__);
    printf("\n");
    exit(1);

} // end of function print_menu_and_get_valid_user_option()

void process_user_option(int option)
{

    switch (option) {

        case 1: __func(option);
                break;
        case 2: __func(option);
                break;
        case 3: __func(option);
                break;
        case 4: printf("\n");
                printf("**THE USER GAVE OPTION NUMBER %d**\n", option);
                printf("\n");
                printf("Exiting..\n");
                printf("\n");
                exit(0);
        default: printf("\n");
                 printf("Line %d: Some BUG in the program. Exiting..\n",
                                                                    __LINE__);
                 printf("\n");
                 exit(1);

    } // end of switch statement

    return;

} // end of function process_user_option()

void __func(int option)
{

    printf("\n");
    printf("**THE USER GAVE OPTION NUMBER %d**\n", option);

    return;

} // end of function __func()

int main(void)
{
    int option = -1;

    while (1) {

        option = print_menu_and_get_valid_user_option();
        process_user_option(option);

    } // end of while loop

} // end of function main()

